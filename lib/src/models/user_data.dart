import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../Services/auth/auth_service.dart';

class UserData with ChangeNotifier {
  String _userName = '';
  String _userAddress = '';
  String _phoneNum = '';
  late String uid = '';

  final _authService = AuthService();

  UserData();
  Future<void> initialize() async {
  final user = _authService.getCurrentUser();
  if (user != null) {
    uid = user.id;

    // Step 1: Try metadata
    _userName = user.userMetadata?['name'] ?? '';
    _phoneNum = user.userMetadata?['phone'] ?? '';
    _userAddress = user.userMetadata?['address'] ?? '';

    final profileData = await Supabase.instance.client
        .from('profiles')
        .select()
        .eq('id', uid)
        .single();

    // Only overwrite if fields are missing
    _userName = _userName.isEmpty ? (profileData['name'] ?? '') : _userName;
    _phoneNum = _phoneNum.isEmpty ? (profileData['phone'] ?? '') : _phoneNum;
    _userAddress =
        _userAddress.isEmpty ? (profileData['address'] ?? '') : _userAddress;

    // Step 3: Update metadata in Supabase
    await Supabase.instance.client.auth.updateUser(UserAttributes(
      data: {
        'name': _userName,
        'phone': _phoneNum,
        'address': _userAddress,
      },
    ));
    notifyListeners();
  } else {
    throw Exception('User is not logged in');
  }
}


  String get userName => _userName;
  String get phoneNum => _phoneNum;
  String get userAddress => _userAddress;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserAddress(String address) {
    _userAddress = address;
    notifyListeners();
  }

  void setPhoneNum(String phone) {
    _phoneNum = phone;
    notifyListeners();
  }
}
