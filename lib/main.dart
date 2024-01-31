import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/controller/dish_controller.dart';

import 'package:machinetest/view/Authentication/login_page.dart';
import 'package:machinetest/view/Tab_1/controller/counter_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

//hey this is my first commit
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: (Platform.isIOS)
        ? const FirebaseOptions(
            apiKey: "AIzaSyB8SwD-Q7c06l17-s_SjmC_wZhSFaYWpe4",
            appId: "1:59388261711:ios:8485c28508b9800897c13a",
            messagingSenderId: "59388261711",
            projectId: "machinetest-31cd1",
          )
        : const FirebaseOptions(
            apiKey: "AIzaSyB8SwD-Q7c06l17-s_SjmC_wZhSFaYWpe4",
            appId: "1:59388261711:android:0feb5621c3d8ceb397c13a",
            messagingSenderId: "59388261711",
            projectId: "machinetest-31cd1",
          ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DishListController(),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: LoginPage(),
        ),
      ),
    );
  }
}
