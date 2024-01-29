import 'package:flutter/material.dart';
import 'package:machinetest/model/dish_model.dart';
import 'package:provider/provider.dart';
import 'package:machinetest/view/Tab_1/controller/counter_provider.dart';
import 'package:sizer/sizer.dart';

class CounterWidget extends StatelessWidget {
  final String dishId;
  final DishListModel dishlist;
  final Color color;

  const CounterWidget({
    super.key,
    required this.dishId,
    required this.dishlist,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    final count = counterProvider.dishCounts[dishId] ?? 0;

    return Container(
      width: 77.sp,
      height: 30.sp,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              counterProvider.decrementCount(dishId);
            },
            child: Text(
              "-",
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
            ),
          ),
          Text(
            count.toString(),
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: 11.sp),
          ),
          GestureDetector(
            onTap: () {
              counterProvider.incrementCount(dishId);
              DishListModel dishes = DishListModel(
                  dishId: dishId,
                  dishName: dishlist.dishName,
                  dishPrice: dishlist.dishPrice,
                  dishImage: dishlist.dishImage,
                  dishCurrency: dishlist.dishCurrency,
                  dishCalories: dishlist.dishCalories,
                  dishDescription: dishlist.dishDescription,
                  dishAvailability: dishlist.dishAvailability,
                  dishType: dishlist.dishType);
              counterProvider.addToSelectedDishes(dishes);
            },
            child: Text(
              "+",
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
            ),
          ),
        ],
      ),
    );
  }

  static provider(BuildContext context) {}
}
