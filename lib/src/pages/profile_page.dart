import 'package:flutter/material.dart';
import 'package:FlavorFleet/Services/auth/auth_service.dart';
import 'package:FlavorFleet/src/pages/edit_profile_page.dart';
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.secondary,
        title: Text(
          'P R O F I L E',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            letterSpacing: 1.5,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: user != null
          ? FutureBuilder(
              future: userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: colorScheme.error),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileHeader(context),
                      const SizedBox(height: 16),
                      _buildProfileOptions(context),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'User not logged in',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: colorScheme.onSurface),
              ),
            ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // const CircleAvatar(
              //   radius: 45,
              //   backgroundImage: AssetImage('lib/assets/profile_picture.png'),
              // ),
              // Positioned(
              //   bottom: 0,
              //   right: 4,
              //   // child: GestureDetector(
              //   //   onTap: () {},
              //   //   child: CircleAvatar(
              //   //     backgroundColor: colorScheme.primary,
              //   //     radius: 16,
              //   //     child: Icon(
              //   //       Icons.camera_alt,
              //   //       size: 16,
              //   //       color: colorScheme.onPrimary,
              //   //     ),
              //   //   ),
              //   // ),
              // ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Hi $userName 👋",
            style: theme.textTheme.titleMedium?.copyWith(
                color: colorScheme.onPrimary, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            "✉️ $userEmail",
            style: theme.textTheme.bodySmall
                ?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptions(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Divider(),
          ExpansionTile(
            collapsedIconColor: colorScheme.secondary,
            iconColor: colorScheme.onPrimary,
            textColor: colorScheme.onSurface,
            title: const Text('Personal Information'),
            leading: Icon(Icons.person, color: colorScheme.onSecondary),
            children: [
              _infoTile(context, 'Name', userName),
              _infoTile(context, 'Email', userEmail),
              _infoTile(context, 'Phone', userPhone),
              _infoTile(context, 'Address', userAddress),
              ListTile(
                title: const Text('Edit'),
                trailing: Icon(Icons.edit, color: colorScheme.secondary),
                onTap: () async {
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
                  if (result) {
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
            collapsedIconColor: colorScheme.secondary,
            iconColor: colorScheme.onPrimary,
            textColor: colorScheme.onSurface,
            title: const Text('Customer Support'),
            leading: Icon(Icons.support_agent, color: colorScheme.onSecondary),
            children: [
              _infoTile(context, 'Email', 'support@flavorfleet.com'),
              _infoTile(context, 'Phone', '+123456789'),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }

  Widget _infoTile(BuildContext context, String title, String value) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListTile(
      title: Text(
        title,
        style: theme.textTheme.bodySmall?.copyWith(
          color: colorScheme.secondary,
        ),
      ),
      subtitle: Text(
        value,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
    );
  }
}
