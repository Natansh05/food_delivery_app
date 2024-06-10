import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/src/pages/settings_page.dart'; // Ensure you import your custom color scheme

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();

  User? user;

  late String userEmail ="";

  @override
  void initState() {
    super.initState();
    user = _authService.getCurrentUser();
    if (user != null) {// Ensure user is not null before accessing properties
      userEmail = user!.email ?? 'No email available';
    } else {
      userEmail = 'No email available';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Profile',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary
        ),),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(context),
            SizedBox(height: 16),
            Text(
              userEmail,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 20),
            _buildProfileDetails(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/profile_picture.png'), // Corrected the path
        onBackgroundImageError: (exception, stackTrace) {
          print('Error loading image: $exception');
        },
      ),
    );
  }

  Widget _buildProfileDetails(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
            title: Text('Personal Information'),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
            onTap: () {
              // Navigate to personal information page
            },
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).colorScheme.secondary),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
            },
            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          ),
          Divider(),
          // Additional list tiles can be added here
        ],
      ),
    );
  }
}
