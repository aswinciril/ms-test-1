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
        barrierDismissible: false,
        builder: (BuildContext context) {
          // Show circular progress indicator dialog
          return AlertDialog(
            title: Text(
              'Signing Out',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  strokeWidth: 3,
                ),
              ],
            ),
          );
        },
      );
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pop();

        counterProvider.clearCart();
        Provider.of<DishListController>(context, listen: false).resetState();

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
              if (user.providerData
                  .any((info) => info.providerId == 'google.com')) {
                googleProvider.signOutFromGoogle();
                logout(context);
              } else {
                logout(context);
              }
            }
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
