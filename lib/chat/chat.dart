import 'package:app_chat/model/user.dart';
import 'package:app_chat/servies/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String nameFriend;
  const Chat({Key? key, required this.nameFriend}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  DatabaseMethod userData = DatabaseMethod();

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('chat')
      .doc("098")
      .collection("234")
      .orderBy("time", descending: false)
      .snapshots();
  bool checkIsUser = true;

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    ScrollController _controller = ScrollController();
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: Container(
                      color: Colors.teal,
                      height: 50,
                      width: 50,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nameFriend,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("Đang hoạt động")
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  return ListView.builder(

                    controller: _controller,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) =>
                        messageChat(message: snapshot.data!.docs[index]["message"],
                        checkUserSend: snapshot.data!.docs[index]["user"] == UserInheritedWidget.of(context).user.name),
                  );
                }
                ))
            ),
            Container(
              color: Colors.white,
              height: 75,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration.collapsed(hintText: "Aa"),
                    ),
                  )),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        userData.sendMessage(
                            user: UserInheritedWidget.of(context).user.name ?? "",
                            message: textEditingController.text);
                      });
                    },
                    child: const SizedBox(
                      height: 50,
                      width: 50,
                      child: Icon(Icons.send),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget messageChat({required String message, required bool checkUserSend}) {
  return Container(
    alignment: checkUserSend ? Alignment.centerRight : Alignment.centerLeft,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30))),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        color: checkUserSend ? Colors.blue : Colors.grey
      ),
      child: Text(message, style: const TextStyle(color: Colors.white),),
    ),
  );
}
