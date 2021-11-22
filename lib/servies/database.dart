import 'package:app_chat/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {

  Future<String> getIdByGmail({required String email}) async {
    String id = "";
    await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((value) => id = value.docs.first.id)
        .catchError((e) {});
    return id;
  }

  Future<String> getEmailById({required String id}) async {
    String email = "";
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .get()
        .then((value) => email = value["email"]);
    return email;
  }

  Future<List<UserData>> getUserByUserName({required String name}) async {
    List<UserData> listUser = [];
    await FirebaseFirestore.instance
        .collection("users")
        .where(
          "name",
          isLessThanOrEqualTo: name,
        )
        .get()
        .then((value) {
      List<UserData> data =
          value.docs.map((e) => UserData.fromJson(e.data())).toList();
      listUser = data;
    });
    return listUser;
  }

  Future<String> checkChatRoomBy2Email({required String emailUser, required String emailFriend}) async {
    String id = "";
    try {
      String idUser = await getIdByGmail(email: emailUser);
      String idFriend = await getIdByGmail(email: emailFriend);
      await FirebaseFirestore.instance
          .collection("chat")
          .where("email.$idUser", isEqualTo: true)
          .where("email.$idFriend", isEqualTo: true)
          .get().then((value) => id = value.docs.first.id);
    } catch (e) {
      id = await newChatRoom(emailUser: emailUser,emailFriend: emailFriend);
    }
    return id;
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

  sendMessage({required String message, required String user}) async {
    Map<String, String> data = {
      "message": message,
      "user": user,
      "time": DateTime.now().millisecondsSinceEpoch.toString()
    };
    await FirebaseFirestore.instance
        .collection("chat")
        .doc("098")
        .collection("234")
        .add(data)
        .then((value) => print("done"));
  }

  Future<String> newChatRoom({required String emailUser, required String emailFriend}) async {
    String idChatRoom = "";
    String idUser = await getIdByGmail(email: emailUser);
    String idFriend = await getIdByGmail(email: emailFriend);

    Map<String, Map<String, bool>> map = {
      "email": {idUser: true, idFriend: true}
    };
    FirebaseFirestore.instance.collection("chat").doc().set(map);
    idChatRoom = await checkChatRoomBy2Email(emailFriend: emailFriend, emailUser: emailUser);
    return idChatRoom;
  }

  Future<List<ChatRoom>> listChatWithUser({required String emailUser}) async {
    String idUser = await getIdByGmail(email: emailUser);
    print(idUser);
    List<ChatRoom> list = [];
    FirebaseFirestore.instance.collection("chat").where("email.$idUser", isEqualTo: true).get().then((value) {
      print(value);
      list = value.docs.map((e) => ChatRoom.fromJson(e.data())).toList();
    }).catchError((e){});
    print(list.first.email);
    return list;
  }
}
