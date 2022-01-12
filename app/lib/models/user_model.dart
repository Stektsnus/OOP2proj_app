import 'package:flutter/material.dart';
import "package:provider/provider.dart";
// User 

class UserNotifier extends ChangeNotifier {
  User? user;
  set userLoggedIn(bool value) {
    user?.isLoggedIn = value;
  }
  UserNotifier({this.user});
}

class User {
  bool isLoggedIn;
  String? username;

  User({this.username, this.isLoggedIn = false});
}