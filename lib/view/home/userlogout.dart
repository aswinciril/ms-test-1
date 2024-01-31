import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/controller/google_controller.dart';
import 'package:machinetest/view/Authentication/login_page.dart';
import 'package:provider/provider.dart';

class UserLogout extends StatelessWidget {
  const UserLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final googleProvider = Provider.of<GoogleProvider>(context);
    return AlertDialog(
      title: const Text('Logout Confirmation'),
      content: const Text('Are you sure you want to Logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final user = FirebaseAuth.instance.currentUser;

            if (user != null && user.providerData.isNotEmpty) {
              // Check if the user is logged in with Google
              if (user.providerData
                  .any((info) => info.providerId == 'google.com')) {
                googleProvider.signOutFromGoogle;
                _logout(context);
              } else {
                // User is not logged in with Google, navigate to login page directly
                _logout(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ));
              }
            }
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    // Call the logout function
    Provider.of<DishListController>(context, listen: false).resetState();
  }
}
