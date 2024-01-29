import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CounterText extends StatelessWidget {
  const CounterText({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 11.sp),
    );
  }
}
