import 'package:app_chat/login/signin/state_signin.dart';
import 'package:app_chat/model/user.dart';
import 'package:app_chat/servies/auth.dart';
import 'package:app_chat/servies/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState>{
  SignInCubit(): super(const SignInState());

  AuthMethod authMethods = AuthMethod();
  DatabaseMethod userData = DatabaseMethod();

  Future<void> signMeIn({required BuildContext context,required String email,required String pass}) async {
    emit(state.copyWith(enumStateSignIn: EnumStateSignIn.loadingSignIn));
      authMethods.signInWithEmailAndPassWord(email: email, password: pass).then((value) async {
        UserInheritedWidget.of(context).user.email = email;
        UserInheritedWidget.of(context).user.name = "";
        await userData.getNameByUserGmail(email: UserInheritedWidget.of(context).user.email ?? "");
        Navigator.of(context).pushNamedAndRemoveUntil("chatRoom", (route) => false);
        emit(state.copyWith(enumStateSignIn: EnumStateSignIn.doneSignIn));
      }).catchError((e) {
        emit(state.copyWith(enumStateSignIn: EnumStateSignIn.errSignIn));
      });
    }

  signInWithGoogle() {
    authMethods.signInWithGoogle();
  }


}
