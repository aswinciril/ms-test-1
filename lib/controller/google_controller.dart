import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/view/home/home_page.dart';
import 'package:provider/provider.dart';

class GoogleProvider extends ChangeNotifier {
  Future<void> signInWithGoogle(BuildContext context) async {
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

  Future<void> signOutFromGoogle() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();

      print("Sign Out Successful");
    } catch (e) {
      print("Sign Out Failed: $e");
      // Handle sign-out failure here
    }
  }
}
