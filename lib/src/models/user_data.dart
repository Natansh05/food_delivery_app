import 'package:flutter/material.dart';

import '../../Services/auth/auth_service.dart';

class UserData with ChangeNotifier {
  String _userName = '';
  String _phoneNum = '';
  late String uid = '';

  final _authService = AuthService();

  UserData() {
    uid = _authService.getCurrentUser()!.id;
    _userName = _authService.getCurrentUser()!.userMetadata?['name'] ?? '';
    _phoneNum = _authService.getCurrentUser()!.userMetadata?['phone'] ?? '';
    notifyListeners();
  }

  String get userName => _userName;
  String get phoneNum => _phoneNum;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setPhoneNum(String phone) {
    _phoneNum = phone;
    notifyListeners();
  }

}
