import 'package:app_chat/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserA?  _user(User? user){
    return user != null ? UserA(userID: user.uid) : null;
  }


  Future signInWithEmailAndPassWord({required String email,required String password}) async {
    try{
      var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       User? fireBaseUser = result.user;
      return _user(fireBaseUser);
    }catch(e){
      throw Exception(e);
    }
  }

  Future signUpWithEmailAndPassWord({required String email,required String password}) async {
    try{
      var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? fireBaseUser = result.user;
      return _user(fireBaseUser);
    }
    catch(e){
      throw Exception(e);
    }
  }

  Future resetPass ({required String email}) async {
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      throw Exception(e);
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e)
    {throw Exception(e);}
  }
}