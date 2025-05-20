import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../auth/auth_service.dart';

class FirestoreService {
  final _authService = AuthService();
 final db = FirebaseFirestore.instance;

  // adding data to database
  Future saveOrderToDatabase(String receipt,String userName,String userPhone,double totalCost,int items,String mode,String delivery) async {
    String formattedDate =  DateFormat.yMMMMd('en_US').format(DateTime.now());
    String formattedTime =  DateFormat.jm().format(DateTime.now());
    await FirebaseFirestore.instance.collection('Orders').add({
      'Note' : userName,
      'Phone ' : userPhone,
      'Date' : formattedDate,
      'Time' : formattedTime,
      'Total Price' : totalCost,
      'No. of Items' : items,
      'Mode of Payment' : mode,
      'Delivery Status' : delivery,
      'User Email' : _authService.getCurrentUser()!.email.toString(),
      'Order' : receipt,
      'Id' : _authService.getCurrentUser()!.uid,
    });
  }

  Future<void> addUserDetail(Map<String, dynamic> userInfoMap, String id) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'Email': userInfoMap['Email'],
      'Password': userInfoMap['Password'],
      'Id': userInfoMap['Id'],
      'Phone': userInfoMap['Phone Number'],
      'Name': userInfoMap['Name'],
      'Adress' : userInfoMap['Adress'],
    });
  }


  Future<void> updateUserDetails(Map<String, dynamic> updateUserInfo, String id)async {
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'Email': updateUserInfo['Email'],
      'Id': updateUserInfo['Id'],
      'Phone': updateUserInfo['Phone Number'],
      'Name': updateUserInfo['Name'],
      'Adress' : updateUserInfo['Adress'],
    });
  }



//   read from database

Stream<QuerySnapshot> getOrderStream(String? userId){
    final orders = db.collection("Orders")
        .where("Id", isEqualTo: userId).snapshots();
    return orders;
}

}
