import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machinetest/custom_widgets/Buttons/custom_button.dart';
import 'package:machinetest/view/Authentication/phone_login/otp_login_page.dart';
import 'package:sizer/sizer.dart';

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController phoneNumberController =
      TextEditingController(text: "+91 - ");
  TextEditingController otpController = TextEditingController();

  Future<void> _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        // Handle successful verification
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failed
        print("Error: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpLoginPage(
            verificationId: verificationId,
          ),
        ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          width: MediaQuery.of(context).size.width * 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 239, 191, 246),
                Color.fromARGB(255, 115, 144, 224)
              ], // Define your gradient colors here.
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(47.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.sp,
                ),
                Image.asset(
                  "assets/login_icons/smartphone.png",
                  height: 100,
                  width: 100,
                ),
                SizedBox(
                  height: 12.sp,
                ),
                Text(
                  "Login",
                  style: GoogleFonts.allura(
                    textStyle: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12.sp,
                ),
                Text(
                  "Enter your mobile number",
                  style: GoogleFonts.basic(
                    textStyle: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 12.sp,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 22.sp,
                ),
                CustomButton(
                  onpressed: _verifyPhoneNumber,
                  width: 10,
                  title: "Get Otp",
                  primarycolor: const Color.fromARGB(255, 113, 208, 114),
                  onprimarycolor: Colors.white,
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Text(
                  "Test Number : 9988776655 ",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Text(
                  "Test OTP : 123456",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
