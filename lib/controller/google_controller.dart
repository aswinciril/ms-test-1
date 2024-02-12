import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:machinetest/view/home/home_page.dart';

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

  String getUserDisplayName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // If user is logged in
      if (user.displayName != null && user.displayName!.isNotEmpty) {
        // If the user has a display name (Google sign-in)
        return user.displayName!;
      } else if (user.phoneNumber != null && user.phoneNumber!.isNotEmpty) {
        // If the user has a phone number (Phone OTP sign-in)
        return user.phoneNumber!;
      }
    }
    // Default value if no user is logged in or no display name/phone number available
    return "Guest User";
  }
}
