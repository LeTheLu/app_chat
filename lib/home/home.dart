import 'dart:async';
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
  List<UserData> list = [];
  Debouncer debouncer = Debouncer(500);

  @override
  void initState() {
    _controllerSearch.text = "trung";
    _controllerSearch.addListener(() {
      debouncer.run(() async {
        list = await userData.getUserByUserName(name: _controllerSearch.text);
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                              style: TextStyle(
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
                  child: ListView.separated(
                      separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Divider(),
                          ),
                      itemCount: list.length,
                      itemBuilder: (context, index) =>
                          user(name: list[index].name ?? "")),
                ),
              ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            userData.chatRoom();
          },
          child: Icon(Icons.add),
        ));
  }

  Widget user({required String name}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "chat", arguments: name);
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
                      name,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    color: Colors.blueAccent,
                    height: 20,
                    width: 20,
                    child: const Center(child: Text("1")),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text("10:10 AM")
              ],
            )
          ],
        ),
      ),
    );
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
}

class Debouncer {
  final int _durationMilliseconds;
  Timer? _timer;
  Function? _currentFn;
  List? _arguments;
  Debouncer(this._durationMilliseconds) {
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
