import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onpressed,
    this.title,
    this.primarycolor,
    this.onprimarycolor,
    required this.width,
    this.icon,
    this.fontweight,
  });

  final Function() onpressed;
  final String? title;
  final double width;
  final Color? primarycolor;
  final Color? onprimarycolor;
  final IconData? icon;
  final FontWeight? fontweight;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primarycolor,
        foregroundColor: onprimarycolor,
        minimumSize: Size(width, 50.sp),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon),
          ],
          SizedBox(
            width: 70.sp,
          ),
          Text(
            title!,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: fontweight,
            ),
          ),
        ],
      ),
    );
  }
}
