import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/view/Authentication/login_page.dart';
import 'package:provider/provider.dart';

class UserLogout extends StatelessWidget {
  Future<void> _signOutFromGoogle(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      print("Sign Out Successful");

      // Navigate back to the login page
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    } catch (e) {
      print("Sign Out Failed: $e");
      // Handle sign-out failure here
    }
  }

  void _logout(BuildContext context) {
    // Call the logout function
    Provider.of<DishListController>(context, listen: false).resetState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Logout Confirmation'),
      content: Text('Are you sure you want to Logout?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final user = FirebaseAuth.instance.currentUser;

            if (user != null && user.providerData.isNotEmpty) {
              // Check if the user is logged in with Google
              if (user.providerData
                  .any((info) => info.providerId == 'google.com')) {
                _signOutFromGoogle(context);
                _logout(context);
              } else {
                // User is not logged in with Google, navigate to login page directly
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));
              }
            }
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
