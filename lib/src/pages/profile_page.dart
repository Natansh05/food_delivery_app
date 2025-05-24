// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/src/pages/edit_profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  User? user;
  late String userEmail = "";
  late String userPhone = "";
  late String userAddress = "";
  late String userName = "";
  late Future<void> userDataFuture;
  @override
  void initState() {
    super.initState();
    user = _authService.getCurrentUser();
    userDataFuture = fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', user!.id)
          .single();
      setState(() {
        userName = response['name'] ?? 'No name available';
        userEmail = response['email'] ?? 'No email available';
        userPhone = response['phone'] ?? 'No phone number available';
        userAddress = response['address'] ?? 'No address available';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'P R O F I L E',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: user != null
          ? FutureBuilder(
              future: userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileHeader(context, userName, userEmail),
                      const SizedBox(height: 16),
                      _buildProfileOptions(
                        context,
                        userName,
                        userEmail,
                        userPhone,
                        userAddress,
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(child: Text('User not logged in')),
    );
  }

  Widget _buildProfileHeader(
      BuildContext context, String userName, String userEmail) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('lib/assets/profile_picture.png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {},
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
        const SizedBox(height: 10),
        Text(userName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(
          userEmail,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildProfileOptions(
    BuildContext context,
    String userName,
    String userEmail,
    String userPhone,
    String userAddress,
  ) {
    return Column(
      children: [
        const Divider(),
        ExpansionTile(
          leading:
              Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
          title: const Text('Personal Information'),
          children: [
            ListTile(title: const Text('Name'), subtitle: Text(userName)),
            ListTile(title: const Text('Email'), subtitle: Text(userEmail)),
            ListTile(title: const Text('Phone'), subtitle: Text(userPhone)),
            ListTile(title: const Text('Address'), subtitle: Text(userAddress)),
            ListTile(
              trailing: Icon(Icons.edit,
                  color: Theme.of(context).colorScheme.secondary),
              title: const Text('Edit'),
              onTap: () async{
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      name: userName,
                      phone: userPhone,
                      address: userAddress,
                    ),
                  ),
                );
                if(result){
                  setState(() {
                    userDataFuture = fetchUserData();
                  });
                }
              },
            ),
          ],
        ),
        const Divider(),
        ExpansionTile(
          leading: Icon(Icons.support_agent,
              color: Theme.of(context).colorScheme.primary),
          title: const Text('Customer Support'),
          children: const [
            ListTile(title: Text('Contact us at support@flavorfleet.com')),
            ListTile(title: Text('Phone: +123456789')),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
