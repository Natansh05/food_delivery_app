import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/Services/auth/auth_service.dart';

class EmailVerificationPage extends StatefulWidget {
  final String email;
  final VoidCallback onClose;

    EmailVerificationPage({
    Key? key,
    required this.email,
    required this.onClose,
  }) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final AuthService _authService = AuthService();
  late Timer _timer;
  Future<bool> userVerified() async {
    await _authService.getCurrentUser()!.reload();
    return _authService.getCurrentUser()!.emailVerified;
  }

  void emailVerificationNotification() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'orders_channel',
          title: 'Email Verification',
          body: 'Your email has been verified successfully!',
          notificationLayout: NotificationLayout.Default,
        ),
      ).then((_) {
        print("Notification created successfully");
      }).catchError((error) {
        print("Error creating notification: $error");
      });
    });
  }


  @override
  void initState(){
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (await userVerified()) {
        _timer.cancel();
        widget.onClose();
        emailVerificationNotification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = _authService.getCurrentUser();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.mark_email_read_rounded,
                size: 64.0,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20.0),
              Text(
                "Verify Your Email",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "We've sent an email to",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[800],
                ),
              ),
              Text(
                "${widget.email}.",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "Please check your inbox and follow the instructions to verify your email address.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await user?.sendEmailVerification();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Verification email will be sent to ${widget.email}",
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                  ),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                child: Text(
                  "Send Verification Email",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: widget.onClose,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.all(16.0),
                  ),
                ),
                child: Text(
                  "Change Email Address",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
