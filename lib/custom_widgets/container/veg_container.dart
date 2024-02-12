import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VegContainer extends StatelessWidget {
  const VegContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11.sp,
      height: 11.sp,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 11, 117, 2),
          width: 2.0,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: Container(
              width: 20.0,
              height: 10.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 11, 117, 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
