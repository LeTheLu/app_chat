import 'dart:async';
import 'package:app_chat/chat/chat.dart';
import 'package:app_chat/model/user.dart';
import 'package:app_chat/servies/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool searchCheck = false;
  final TextEditingController _controllerSearch = TextEditingController();
  DatabaseMethod userData = DatabaseMethod();
  Delay debouncer = Delay(500);
  String emailUser = '';

  List list = [];
  List<UserData> listSearch = [];

  getListSearch() async {
    listSearch = await userData.getUserByUserName(name: _controllerSearch.text);
    listSearch.removeWhere((element) => element.name == UserInheritedWidget.of(context).user.name);
    setState(() {
    });
  }
  getListHistory() async {
    emailUser = UserInheritedWidget.of(context).user.email!;
    list = await userData.getIdChatRoomsByEmailUserHome(emailUser:emailUser);
    setState(() {});
  }

@override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getListHistory();
    });
  super.initState();
    _controllerSearch.addListener(() {
      if(_controllerSearch.text == ""){
        getListHistory();
      }
      Delay(700);
      getListSearch();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.cyan[200],
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        avatarUser(),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UserInheritedWidget.of(context).user.name ??
                                  'User',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container(
                                      color: Colors.green,
                                      height: 10,
                                      width: 10,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Đang hoạt động",
                                  style: TextStyle(color: Colors.grey[900]),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          searchCheck = !searchCheck;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        height: 40,
                        width: 40,
                        child: const Icon(Icons.search, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Visibility(
                    visible: searchCheck,
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30)),
                            border: Border.all(color: Colors.teal)),
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: _controllerSearch,
                              decoration: const InputDecoration.collapsed(
                                  hintText: "Search ... "),
                            ),
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                  child: Opacity(
                opacity: 0.7,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  height: double.infinity,
                  width: double.infinity,
                  child: listSearch.isEmpty
                      ? ListView.separated(
                      separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(),
                          ),
                      itemCount: list.length,
                      itemBuilder: (context, index){
                       return UserFriend(idChatRoom: list[index],nameFriend: getItem(list[index]));
                         //userFriend(name: "nameFriend",idChatRoom: list[index]);
                      }
                )
                      : ListView.builder(
                    itemCount: listSearch.length,
                      itemBuilder: (context, index) =>
                      UserFriendSearch(userFriend: listSearch[index])),
              )))
            ],
          ),
        ),
    );
  }
  getItem(String idChatRoom) async {
    String id = await userData.getIdFriendInChatRoom(emailUser: UserInheritedWidget.of(context).user.email ?? "" ,idChatRoom: idChatRoom );
    String nameFriend = await userData.getNameById(id: id);
    return nameFriend;
  }
}


class UserFriend extends StatefulWidget {
  final String idChatRoom;
  final String nameFriend;

  const UserFriend({Key? key,required this.idChatRoom,required this.nameFriend}) : super(key: key);

  @override
  State<UserFriend> createState() => _UserFriendState();
}
class _UserFriendState extends State<UserFriend> {
  DatabaseMethod userData = DatabaseMethod();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async  {

      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => Chat(idChatRoom: widget.idChatRoom,nameFriend: widget.nameFriend,)));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                avatarUser(),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.nameFriend,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("messenger",
                        style: TextStyle(color: Colors.grey, fontSize: 15))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserFriendSearch extends StatefulWidget {
  final UserData userFriend;
  const UserFriendSearch({Key? key,required this.userFriend}) : super(key: key);

  @override
  State<UserFriendSearch> createState() => _UserFriendSearchState();
}
class _UserFriendSearchState extends State<UserFriendSearch> {
  DatabaseMethod userData = DatabaseMethod();
  String idChatRoom = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        idChatRoom = await userData.getIdChatRoomBy2Email(emailUser: UserInheritedWidget.of(context).user.email ?? "",emailFriend: widget.userFriend.email??"");
        await Navigator.push(context, MaterialPageRoute(builder: (_) => Chat(idChatRoom: idChatRoom,nameFriend: widget.userFriend.name ?? "",)));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                avatarUser(),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userFriend.name ?? "",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("messenger",
                        style: TextStyle(color: Colors.grey, fontSize: 15))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class Delay {
  final int _durationMilliseconds;
  Timer? _timer;
  Function? _currentFn;
  List? _arguments;
  Delay(this._durationMilliseconds) {
    _resetTimer();
  }

  _resetTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: _durationMilliseconds), () {
      if (_currentFn != null) {
        Function.apply(_currentFn!, _arguments);
      }
    });
  }

  run(Function fn, [List args = const []]) {
    _currentFn = fn;
    _arguments = args;
    _resetTimer();
  }
}
Widget avatarUser() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(50),
    child: Container(
      color: Colors.teal,
      height: 70,
      width: 70,
    ),
  );
}
