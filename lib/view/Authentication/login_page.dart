import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/custom_widgets/Buttons/custom_button.dart';
import 'package:machinetest/view/Authentication/phone_login/phone_login_page.dart';
import 'package:machinetest/view/home/home_page.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("Google Sign-In canceled by user.");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      print("Google Sign-In Successful: ${userCredential.user?.displayName}");

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const HomePage(),
      ));
    } catch (e) {
      print("Google Sign-In Failed: $e");
    }
  }

  Future<void> _signOutFromGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      print("Sign Out Successful");
    } catch (e) {
      print("Sign Out Failed: $e");
      // Handle sign-out failure here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50.sp,
            ),
            Center(
              child: Image.network(
                "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Firebase_icon.svg/2048px-Firebase_icon.svg.png",
                height: 220,
              ),
            ),
            SizedBox(
              height: 120.sp,
            ),
            CustomButton(
              onpressed: () {
                _signInWithGoogle(context);
              },
              width: 10,
              title: "Google",
              icon: FontAwesomeIcons.google,
              primarycolor: Colors.blue,
              onprimarycolor: Colors.white,
            ),
            SizedBox(
              height: 10.sp,
            ),
            CustomButton(
              onpressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PhoneLoginPage(),
                ));
              },
              width: 10,
              title: "Phone",
              icon: Icons.call,
              primarycolor: const Color.fromARGB(255, 4, 234, 38),
              onprimarycolor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
