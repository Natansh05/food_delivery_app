import 'package:flutter/material.dart';


class UserData with ChangeNotifier {
  String _userName = '';
  String _phoneNum = '';
  bool _del = true;
  bool _cod = true;

  String get userName => _userName;
  String get phoneNum => _phoneNum;
  bool get delivery => _del;
  bool get cash => _cod;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setDelivery(bool isDel){
    _del = isDel;
    notifyListeners();
  }

  void setCod(bool isCod){
    _cod = isCod;
    notifyListeners();
  }

  void setPhoneNum(String phone) {
    _phoneNum = phone;
    notifyListeners();
  }
}
