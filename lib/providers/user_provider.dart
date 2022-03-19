import 'package:flutter/material.dart';
import 'package:instagramclone/Models/user.dart';

class UserProvider extends ChangeNotifier {
  User? user;
  Future<void> refreshUser() async {}
}
