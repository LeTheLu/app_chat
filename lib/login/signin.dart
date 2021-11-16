import 'package:app_chat/model/user.dart';
import 'package:app_chat/servies/auth.dart';
import 'package:app_chat/servies/database.dart';
import 'package:app_chat/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final keyFormSignIn = GlobalKey<FormState>();

  bool checkHind = true;
  bool isLoad = false;
  bool checkSignInErr = false;

  final TextEditingController _controllerGmail = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  AuthMethod authMethods = AuthMethod();
  DatabaseMethod userData = DatabaseMethod();
  UserData userYou = UserData();

  signMeIn() {
    if (keyFormSignIn.currentState!.validate()) {
      setState(() {
        isLoad = true;
      });
      authMethods
          .signInWithEmailAndPassWord(
              email: _controllerGmail.text, password: _controllerPass.text)
          .then((value) async {
        UserInheritedWidget.of(context).user.email = _controllerGmail.text;
        UserInheritedWidget.of(context).user.name = await userData.getNameByUserGmail(email: UserInheritedWidget.of(context).user.email ?? "");
        return Navigator.pushNamed(context, "chatRoom");
      }).catchError((e) {
        setState(() {
          checkSignInErr = true;
          isLoad = false;
          _controllerPass.text = "";
        });
      });
    }
  }
  signInWithGoogle(){
    authMethods.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[200],
        body: Stack(children: [
          SafeArea(
            child: isLoad
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          logoFlutter(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              color: Colors.cyan[500],
                            ),
                            width: MediaQuery.of(context).size.width - 30,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Form(
                                    key: keyFormSignIn,
                                    child: Column(
                                      children: [
                                        textFieldGmail(
                                            "Gmail", _controllerGmail),
                                        passWord(
                                            controller: _controllerPass,
                                            checkHind: checkHind,
                                            onPressed: () {
                                              setState(() {
                                                checkHind = !checkHind;
                                              });
                                            }),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          buttonHome(
                              context: context,
                              label: "SignIn",
                              onPressed: () {
                                signMeIn();
                              }),
                          const SizedBox(
                            height: 30,
                          ),
                          buttonHome(
                              context: context,
                              label: "Google",
                              onPressed: () {
                                signInWithGoogle();
                              },
                              colorButton: Colors.white,
                              colorText: Colors.black),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Bạn chưa có tài khoảng?"),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "signup");
                                },
                                child: const Text(
                                  "Đăng Kí ngay!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
          ),
          Visibility(
              visible: checkSignInErr,
              child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal[500],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    height: 100,
                    width: 250,
                    child: Stack(
                      children: [
                        const Center(
                            child: Text(
                          "Đăng nhập không thành công",
                          style: TextStyle(color: Colors.white),
                        )),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                checkSignInErr = false;
                              });
                            },
                            child: const SizedBox(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.clear, color: Colors.white,),
                            ),
                          ),
                        )
                      ],
                    )),
              ))
        ]));
  }
}
