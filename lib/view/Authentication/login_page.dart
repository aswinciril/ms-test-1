import 'package:flutter/material.dart';
import 'package:machinetest/controller/google_controller.dart';
import 'package:machinetest/custom_widgets/Buttons/custom_button.dart';
import 'package:machinetest/view/Authentication/phone_login/phone_login_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    final googleProvider = Provider.of<GoogleProvider>(context);
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
                googleProvider.signInWithGoogle(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const HomePage(),
                //     ));
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
