import 'package:app_chat/servies/auth.dart';
import 'package:app_chat/widget/widget.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}



class _SignUpState extends State<SignUp> {
  bool checkHind = true;
  bool isLoad = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerUser = TextEditingController();
  final TextEditingController _controllerPass = TextEditingController();

  AuthMethod authMethods  = AuthMethod();

  signMeUp(){
    if(formKey.currentState!.validate()) {
      setState(() {
        isLoad = true;
      });
      authMethods.signUpWithEmailAndPassWord(email: _controllerUser.text, password: _controllerPass.text).then((e) {
        Navigator.pushNamed(context, "chatRoom");
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[200],
      body: SafeArea(
        child: isLoad? Container(child: Center(child: CircularProgressIndicator(),),) :SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Đăng Ký", style: TextStyle(fontWeight: FontWeight.bold, color:Colors.white, fontSize: 30),),
                const SizedBox(height: 20,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.cyan[500],
                  ),
                  width: MediaQuery.of(context).size.width - 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: formKey,
                          child: Column(
                            children: [
                              textFieldName("Name", _controllerName),
                              textFieldGmail("User", _controllerUser),
                              passWord(controller: _controllerPass, checkHind: checkHind, onPressed: () {setState(() {checkHind = !checkHind;});}),
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buttonHome(context: context, label: "SignUp", onPressed: () {
                  signMeUp();
                }),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn đã có tài khoản?"),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Đăng nhập ngay!",
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
    );
  }
}
