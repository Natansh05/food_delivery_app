import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/src/pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  User? user;

  @override
  void initState() {
    super.initState();
    user = _authService.getCurrentUser();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      return {
        'userName': userData['Name'] ?? 'No name available',
        'userEmail': user!.email ?? 'No email available',
        'userPhone': userData['Phone'] ?? 'No phone number available',
        'userAddress': userData['Adress'] ?? 'No address available',
        'memberId': user!.uid
      };
    }
    return {
      'userName': 'No name available',
      'userEmail': 'No email available',
      'userPhone': 'No phone number available',
      'userAddress': 'No address available',
      'memberId': 'No ID available'
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'P R O F I L E',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: user != null
          ? FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No user data found'));
          }

          var userData = snapshot.data!;
          String userName = userData['userName'];
          String userEmail = userData['userEmail'];
          String userPhone = userData['userPhone'];
          String userAddress = userData['userAddress'];
          String memberId = userData['memberId'];

          return SingleChildScrollView(
            child: Column(
              children: [
                _buildProfileHeader(context, userName, userEmail),
                SizedBox(height: 16),
                _buildProfileOptions(context, userName, userEmail, userPhone, userAddress, memberId),
              ],
            ),
          );
        },
      )
          : Center(child: Text('User not logged in')),
    );
  }

  Widget _buildProfileHeader(BuildContext context, String userName, String userEmail) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 40,
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
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 15,
                  child: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          userName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          userEmail,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildProfileOptions(BuildContext context, String userName, String userEmail, String userPhone, String userAddress, String memberId) {
    return Column(
      children: [
        Divider(),
        ExpansionTile(
          leading: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
          title: Text('Personal Information'),
          children: [
            ListTile(
              title: Text('Name'),
              subtitle: Text(userName),
            ),
            ListTile(
              title: Text('Email'),
              subtitle: Text(userEmail),
            ),
            ListTile(
              title: Text('Phone'),
              subtitle: Text(userPhone),
            ),
            ListTile(
              title: Text('Address'),
              subtitle: Text(userAddress),
            ),
            ListTile(
              trailing: Icon(Icons.edit, color: Theme.of(context).colorScheme.secondary),
              title: Text('Edit'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfilePage(
                  phone: userPhone,
                  Adress: userAddress,
                  name: userName,
                )));
              },
            ),
          ],
        ),
        Divider(),
        ExpansionTile(
          leading: Icon(Icons.support_agent, color: Theme.of(context).colorScheme.primary),
          title: Text('Customer Support'),
          children: [
            ListTile(
              title: Text('Contact us at support@flavorfleet.com'),
            ),
            ListTile(
              title: Text('Phone: +123456789'),
            ),
          ],
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.badge, color: Theme.of(context).colorScheme.primary),
          title: Text('Member ID'),
          subtitle: Text(memberId),
          trailing: IconButton(
            icon: Icon(Icons.copy, color: Theme.of(context).colorScheme.secondary),
            onPressed: () {
              // Implement copy functionality
            },
          ),
        ),
        Divider(),
      ],
    );
  }
}
