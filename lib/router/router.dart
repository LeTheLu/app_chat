

import 'package:app_chat/chat/chat.dart';
import 'package:app_chat/home/home.dart';
import 'package:app_chat/login/login_ui.dart';
import 'package:flutter/material.dart';

class RouteName{
  static const String login = "login";
  static const String home = "/";
  static const String chat = "chat";
}

class Routes{
  static Route<dynamic>? generate(RouteSettings settings){

    switch (settings.name){
      case "login": {
        return MaterialPageRoute(builder: (_) => const Login());
      }
      case "/":
        {
          return MaterialPageRoute(builder: (_) =>const Home());
        }
      case "chat":
        {
          return MaterialPageRoute(builder: (_) =>const Chat());
        }
    }
  }
}