// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flavorfleet/Services/auth/auth_service.dart';
import 'package:flavorfleet/src/common%20widgets/progress_indicator.dart';
import 'package:flavorfleet/src/common%20widgets/success_snackbar.dart';
import 'package:flavorfleet/src/models/user_data.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends StatefulWidget {
  final String phone;
  final String address;
  final String name;

  const EditProfilePage({
    super.key,
    required this.phone,
    required this.address,
    required this.name,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final AuthService authService = AuthService();
  late final User? user;
  late String userEmail = "";
  String userPhone = "";
  String userAddress = "";
  late String userName = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    user = authService.getCurrentUser();
    if (user != null) {
      userEmail = user!.email ?? 'No email available';
      userName = widget.name;
      nameController.text = userName;
      emailController.text = userEmail;
      phoneController.text = widget.phone;
      addressController.text = widget.address;
    }
  }

  Future<void> updateUserData(
    String address,
    String name,
    String phoneNumber,
  ) async {
    final uid = user?.id;

    if (uid == null) return;
    debugPrint("User ID: $uid");
    final response = await Supabase.instance.client
        .from('profiles')
        .update({'name': name, 'phone': phoneNumber, 'address': address})
        .eq('id', uid)
        .select();

    if (response.isEmpty) {
      final snackbar = successSnackBar(
        context,
        "Profile Updation Failed",
        false,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      final snackbar = successSnackBar(
        context,
        "Profile Updated Successfully",
        true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      await Provider.of<UserData>(context, listen: false).initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'E D I T    P R O F I L E',
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Stack(
                children: [
                  // const CircleAvatar(
                  //   radius: 75,
                  //   backgroundImage:
                  //       AssetImage('lib/assets/profile_picture.png'),
                  // ),
                  // Positioned(
                  //   bottom: 0,
                  //   right: 0,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Add logic to update profile image
                  //     },
                  //     child: CircleAvatar(
                  //       backgroundColor: colorScheme.secondary,
                  //       radius: 20,
                  //       child: Icon(Icons.camera_alt,
                  //           color: colorScheme.onPrimary),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      labelStyle: TextStyle(
                        color: colorScheme.secondary.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone No',
                      labelStyle: TextStyle(
                        color: colorScheme.secondary.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      labelText: 'Default Address',
                      labelStyle: TextStyle(
                        color: colorScheme.secondary.withOpacity(0.7),
                      ),
                      prefixIcon: Icon(
                        Icons.home,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    style: TextStyle(color: colorScheme.onSurface),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          addressController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          successSnackBar(
                            context,
                            "Please fill all the fields",
                            false,
                          ),
                        );
                        return;
                      }
                      showLoadingDialog(context);
                      await updateUserData(
                        addressController.text.trim(),
                        nameController.text.trim(),
                        phoneController.text.trim(),
                      );
                      hideLoadingDialog(context);
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                    ),
                    child: const Text('Edit Profile'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Joined on Supabase',
                    style: TextStyle(
                      color: colorScheme.onPrimary.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      // Add delete logic if needed
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Delete'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
