import 'package:app_chat/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future<List<UserData>> getUserByUserName({required String name}) async {
    List<UserData> listUser = [];
    await FirebaseFirestore.instance
        .collection("users")
        .where("name", isLessThanOrEqualTo: name,)
        .get()
        .then((value) {
      List<UserData> data =
          value.docs.map((e) => UserData.fromJson(e.data())).toList();
      listUser = data;
    });
    return listUser;
  }

  Future<String?> getNameByUserGmail({required String email}) async {
    UserData user = UserData();
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) {
       user = value.docs.map((e) => UserData.fromJson(e.data())).toList().first;
    });
    return user.name;
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  sendMessage({required String message,required String user}) async {
    Map<String, String> data = {
      "message" : message,
      "user" : user,
      "time" : DateTime.now().millisecondsSinceEpoch.toString()
    };
    await FirebaseFirestore.instance.collection("chat").doc("098").collection("234").add(data).then((value) => print("done"));

  }

  chatRoom() async {

}
