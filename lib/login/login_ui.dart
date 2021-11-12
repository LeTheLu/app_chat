import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.cyan[300],
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  height: 150,
                  width: 150,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: const FlutterLogo(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.cyan[500],
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: TextField(
                            decoration: InputDecoration.collapsed(
                              hintText: "Name",
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Password",
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 20,
                              width: 20,
                              child: Icon(Icons.eleven_mp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        color: Colors.cyan[500],
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width - 30,
                      child: const Center(child: Text("SignIn", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400)),)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration:  BoxDecoration(
                        color: Colors.cyan[500],
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 80,
                      width: 80,
                      child: const Icon(Icons.phone, color: Colors.white,),
                    ),
                    const SizedBox(width: 20,),
                    Container(
                      decoration:  BoxDecoration(
                        color: Colors.cyan[500],
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      height: 80,
                      width: 80,
                      child: const Icon(Icons.phone, color: Colors.white,),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
