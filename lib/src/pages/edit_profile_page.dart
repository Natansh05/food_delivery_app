// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/src/common%20widgets/progress_indicator.dart';
import 'package:myapp/src/common%20widgets/success_snackbar.dart';
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

  Future<void> updateUserData(String address, String name, String phoneNumber) async {
    final uid = user?.id;

    if (uid == null) return;
    debugPrint("User ID: $uid");
    final response = await Supabase.instance.client
        .from('profiles')
        .update({
          'name': name,
          'phone': phoneNumber,
          'address': address,
        })
        .eq('id', uid)
        .select();

    if (response.isEmpty) {
      final snackbar =
          successSnackBar(context, "Profile Updation Failed", false);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      final snackbar = successSnackBar(
        context,
        "Profile Updated Successfully",
        true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'E D I T  P R O F I L E',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              // Implement profile image change logic
            },
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              radius: 20,
              child: Icon(Icons.camera_alt,
                  color: Theme.of(context).colorScheme.onPrimary, size: 20),
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
          _buildTextField('Phone No', phoneController, Icons.phone),
          SizedBox(height: 10),
          _buildTextField('Default Address', addressController, Icons.home),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isEmpty ||
                  phoneController.text.isEmpty ||
                  addressController.text.isEmpty) {
                final snackbar = successSnackBar(
                    context, "Please fill all the fields", false);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
                return;
              }
              showLoadingDialog(context);
              await updateUserData(
                addressController.text.trim(),
                nameController.text.trim(),
                phoneController.text.trim(),
              );
              hideLoadingDialog(context);
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
            'Joined on Supabase',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              // Implement account deletion logic if needed
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
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
