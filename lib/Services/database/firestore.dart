import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../auth/auth_service.dart';

class FirestoreService {
  final _authService = AuthService();
  Future saveOrderToDatabase(String receipt,String userName,String userPhone,double totalCost,int items,String mode,String delivery) async {
    String formattedDate =  DateFormat.yMMMMd('en_US').format(DateTime.now());
    String formattedTime =  DateFormat.jm().format(DateTime.now());
    await FirebaseFirestore.instance.collection('Orders').add({
      'Name' : userName,
      'Phone ' : userPhone,
      'Date' : formattedDate,
      'Time' : formattedTime,
      'Total Price' : totalCost,
      'No. of Items' : items,
      'Mode of Payment' : mode,
      'Delivery Status' : delivery,
      'User Email' : _authService.getCurrentUser()!.email.toString(),
      'Order' : receipt,
    });
  }

  Future addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Email' : userInfoMap['Email'],
      'Password' : userInfoMap['Password'],
      'Id' : userInfoMap['Id'],
    });
  }
}
