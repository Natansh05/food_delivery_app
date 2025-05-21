import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Services/auth/auth_service.dart';

class UserData with ChangeNotifier {
  String _userName = '';
  String _phoneNum = '';
  bool _del = true;
  bool _cod = true;
  late String uid = '';

  final _authService = AuthService();

  UserData() {
    uid = _authService.getCurrentUser()!.uid;
    updatePhoneNum();
  }

  String get userName => _userName;
  String get phoneNum => _phoneNum;
  bool get delivery => _del;
  bool get cash => _cod;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setDelivery(bool isDel) {
    _del = isDel;
    notifyListeners();
  }

  void setCod(bool isCod) {
    _cod = isCod;
    notifyListeners();
  }

  void setPhoneNum(String phone) {
    _phoneNum = phone;
    notifyListeners();
  }

  Future<void> updatePhoneNum() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        _phoneNum = userDoc['Phone'] ?? '';
        _userName = userDoc['Name'] ?? '';
        notifyListeners();
      }
    } catch (e) {
      // Handle errors here
      print('Error updating phone number: $e');
    }
  }
}
