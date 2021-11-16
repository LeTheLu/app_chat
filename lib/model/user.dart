import 'package:flutter/cupertino.dart';

class UserData {
  String? userID;
  String? name;
  String? email;

  UserData({this.userID, this.name, this.email});

  UserData.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userID'] = userID;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}

class UserInheritedWidget extends InheritedWidget {
  final UserData user;

  const UserInheritedWidget({Key? key, required Widget child, required this.user}) : super(key: key, child: child);

  static UserInheritedWidget of(BuildContext context) {
    final UserInheritedWidget? result = context.dependOnInheritedWidgetOfExactType<UserInheritedWidget>();
    assert(result != null, 'No User found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(UserInheritedWidget oldWidget) {
    return user != oldWidget.user;
  }
}
