import 'package:flutter/material.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/view/Authentication/login_page.dart';
import 'package:provider/provider.dart';

class UserLogout extends StatelessWidget {
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            ); // Close the dialog
            // Call the logout function
            Provider.of<DishListController>(context, listen: false)
                .resetState();
          },
          child: Text('Logout'),
        ),
      ],
    );
  }
}
