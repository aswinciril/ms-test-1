import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DishImage extends StatelessWidget {
  const DishImage({
    super.key,
    required this.dishimage,
  });
  final String dishimage;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      dishimage,
      fit: BoxFit.cover,
    );
  }
}

class DishAddons extends StatelessWidget {
  const DishAddons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Customizations Available",
      style: TextStyle(color: Colors.red),
    );
  }
}

class DishDescription extends StatelessWidget {
  const DishDescription({
    super.key,
    required this.description,
  });
  final String description;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190.sp,
      child: Text(
        description,
        maxLines: 4,
        overflow: TextOverflow.visible,
        style:
            TextStyle(fontSize: 10.sp, color: Color.fromARGB(255, 96, 93, 93)),
      ),
    );
  }
}

class DishCalorie extends StatelessWidget {
  const DishCalorie({
    super.key,
    required this.calorie,
  });
  final String calorie;
  @override
  Widget build(BuildContext context) {
    return Text(
      "$calorie Calories",
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}

class DishPrice extends StatelessWidget {
  const DishPrice({
    super.key,
    required this.dishPrice,
  });
  final double dishPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "INR :",
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 3.sp,
        ),
        Text(
          dishPrice.toString(),
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class DishName extends StatelessWidget {
  const DishName({
    super.key,
    required this.dishName,
  });
  final String dishName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160.sp,
      child: Text(
        dishName,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
