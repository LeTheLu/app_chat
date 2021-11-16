import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String nameFriend;
  const Chat({Key? key,required this.nameFriend}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();
  Stream documentStream = FirebaseFirestore.instance.collection('users').doc('ABC123').snapshots();

  


  @override
  Widget build(BuildContext context) {
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
                    onPressed: (){
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
                  const SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nameFriend, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
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
                )),
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
                          borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: const TextField(
                          decoration: InputDecoration.collapsed(hintText: "Aa"),
                        ),
                      )),
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.send),
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
