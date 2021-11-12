import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        children: [
          Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.cyan,
              )),
          Container(
            color: Colors.white,
            height: 80,
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
                Container(
                  height: 50,
                  width: 50,
                  child: Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
