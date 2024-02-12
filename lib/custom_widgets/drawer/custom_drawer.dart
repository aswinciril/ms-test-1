import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/view/home/userlogout.dart';
import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.getUserDisplayName});
  final Function() getUserDisplayName;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid.substring(0, 4) ?? 'Guest';
    return Drawer(
      width: 270.sp,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 63, 156, 66),
                  Color.fromARGB(255, 33, 243, 100),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            height: 190.sp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                CircleAvatar(
                  backgroundImage: const AssetImage("assets/images/dishdp.jpg"),
                  radius: 40.sp,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  getUserDisplayName(),
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 3.sp,
                ),
                Text(
                  "ID :$userId ",
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Log out"),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const UserLogout();
                  });
            },
          )
        ],
      ),
    );
  }
}
