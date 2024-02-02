import 'package:flutter/material.dart';
import 'package:machinetest/custom_widgets/container/non_veg_container.dart';
import 'package:machinetest/custom_widgets/container/veg_container.dart';
import 'package:machinetest/custom_widgets/dish_details/dish_details.dart';
import 'package:machinetest/model/dish_model.dart';
import 'package:machinetest/view/Tab_1/widgets/counter_widget.dart';
import 'package:sizer/sizer.dart';

class FoodDetailContainer extends StatelessWidget {
  const FoodDetailContainer({
    super.key,
    required this.dishlist,
  });
  final DishListModel dishlist;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.sp),
      child: Container(
        padding: EdgeInsets.all(7.sp),
        height: dishlist.addonCat != null && dishlist.addonCat!.isNotEmpty
            ? 180.sp
            : 149.sp,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10.sp,
                ),
                if (dishlist.dishType == 1)
                  const NonVegContainer()
                else
                  const VegContainer()
              ],
            ),
            SizedBox(
              width: 12.sp,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DishName(
                  dishName: dishlist.dishName,
                ),
                Row(
                  children: [
                    DishPrice(dishPrice: dishlist.dishPrice),
                    SizedBox(
                      width: 61.sp,
                    ),
                    DishCalorie(
                      calorie: dishlist.dishCalories.toString(),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                DishDescription(
                  description: dishlist.dishDescription.toString(),
                ),
                SizedBox(
                  height: 13.sp,
                ),
                CounterWidget(
                  color: const Color.fromARGB(255, 86, 190, 89),
                  dishId: dishlist.dishId,
                  dishlist: dishlist,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                if (dishlist.addonCat != null && dishlist.addonCat!.isNotEmpty)
                  const DishAddons(),
              ],
            ),
            SizedBox(
              width: 5.sp,
            ),
            Container(
              height: 90.0,
              width: 75.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 171, 171, 171),
                  width: 1.0,
                ),
              ),
              child: DishImage(
                dishimage: dishlist.dishImage.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
