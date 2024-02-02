import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class NonVegContainer extends StatelessWidget {
  const NonVegContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11.sp, // Adjust the size of the square as needed
      height: 11.sp,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 255, 1, 1), // Outline color
          width: 2.0, // Outline width
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              width: 20.0, // Adjust the size of the dot as needed
              height: 10.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red, // Dot color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
