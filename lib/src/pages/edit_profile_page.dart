import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/Services/database/firestore.dart';

class EditProfilePage extends StatefulWidget {
  final String phone;
  final String address;
  final String name;

  const EditProfilePage({super.key, 
    required this.phone,
    required this.address,
    required this.name,
});


  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}


class _EditProfilePageState extends State<EditProfilePage> {
  final AuthService _authService = AuthService();
  final FirestoreService db = FirestoreService();
  User? user;
  late String userEmail = "";
  String userPhone = "";
  String userAddress = "";
  late String userName = "";
  // Initial values for the profile fields
  final TextEditingController nameController = TextEditingController(text: "John Doe");
  final TextEditingController emailController = TextEditingController(text: "john.doe@example.com");
  final TextEditingController phoneController = TextEditingController(text: "Not Specified Yet");
  final TextEditingController addressController = TextEditingController(text: "Not Specified Yet");

  @override
  void initState() {
    super.initState();
    user = _authService.getCurrentUser() as User?;
    if (user != null) { // Ensure user is not null before accessing properties
      userEmail = user!.email ?? 'No email available';
      userName = widget.name;
      nameController.text = userName;
      emailController.text = userEmail; // Set email controller to user email
      phoneController.text = widget.phone;
      addressController.text = widget.address;
    } else {
      userEmail = 'No email available';
      userPhone = 'No phone number available';
      userName = 'No name available';
    }
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      setState(() {
        userName = userData['Name'] ?? 'No name available';
        userPhone = userData['Phone'] ?? 'No phone number available';
        userAddress = userData['Address'] ?? 'No address available';
      });
    }
  }

 Future<void> updateUserData(User? user, String email, String address, String name,
     String phoneNumber) async{
   final FirestoreService db = FirestoreService();
   Map<String, dynamic> updateUserInfo = {
     "Email": email,
     "Name": name,
     "Phone Number": phoneNumber,
     "Id": user!.uid,
     "Adress" : address,
   };

   db.updateUserDetails(updateUserInfo,user.uid);
 }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'E D I T  P R O F I L E',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            SizedBox(height: 16),
            _buildProfileForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 75,
          backgroundImage: AssetImage('lib/assets/profile_picture.png'),
          onBackgroundImageError: (exception, stackTrace) {
            print('Error loading image: $exception');
          },
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              // Add functionality to change the profile picture
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 20,
              child: Icon(
                Icons.camera_alt,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildTextField('Full Name', nameController, Icons.person),
          SizedBox(height: 10),
          // _buildTextField('E-Mail', emailController, Icons.email),
          SizedBox(height: 10),
          _buildTextField('Phone No', phoneController, Icons.phone),
          SizedBox(height: 10),
          _buildTextField('Default Address', addressController, Icons.home),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              userEmail = emailController.text;
              userPhone = phoneController.text;
              userAddress = addressController.text;
              userName = nameController.text;
              updateUserData(user, userEmail, userAddress, userName, userPhone);
              // Implement update logic here
              // Example: updateUserProfile(nameController.text, emailController.text, phoneController.text, addressController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              foregroundColor: Theme.of(context).colorScheme.primary,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              textStyle: TextStyle(fontSize: 16),
            ),
            child: Text('Edit Profile'),
          ),
          SizedBox(height: 20),
          Text(
            'Joined 31 October 2022',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}
