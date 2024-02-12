import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/controller/counter_provider.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/controller/google_controller.dart';
import 'package:machinetest/view/Authentication/login_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserLogout extends StatelessWidget {
  const UserLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    void logout(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dialog from closing on outside tap
        builder: (BuildContext context) {
          // Show circular progress indicator dialog
          return AlertDialog(
            title: Text(
              'Signing Out',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            content: const CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 0, 0, 0)),
            ),
          );
        },
      );

      // Delay execution for 3 seconds
      Future.delayed(const Duration(seconds: 3), () {
        // Close the dialog
        Navigator.of(context).pop();

        // Call the logout function
        counterProvider.clearCart();
        Provider.of<DishListController>(context, listen: false).resetState();

        // Redirect to login page
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
      });
    }

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
                googleProvider.signOutFromGoogle();
                logout(context);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const LoginPage(),
                // ));
              } else {
                // User is not logged in with Google, navigate to login page directly
                logout(context);
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const LoginPage(),
                // ));
              }
            }
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
