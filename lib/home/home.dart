import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                children: [
                  avatarUser(),
                  const SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("User", style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black, fontSize: 20),),
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
                          Text("Đang hoạt động", style: TextStyle(color: Colors.grey[900]),
                          )],
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                child: Opacity(
                  opacity: 0.7,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                    ),
                    height: double.infinity,
                    width: double.infinity,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(),
                      ),
                      itemCount: 4,
                        itemBuilder:(context, index) => user()),
                  ),
                ))
          ],
        ),
      ),
    );
  }
  Widget user(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              avatarUser(),
              const SizedBox(width: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("User", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Text("messenger", style: TextStyle(color: Colors.grey, fontSize: 15))
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
              const SizedBox(height: 15,),
              const Text("10:10 AM")
            ],
          )
        ],
      ),
    );
  }
  Widget avatarUser(){
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
