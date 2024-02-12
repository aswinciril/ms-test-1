import 'package:flutter/material.dart';
import 'package:machinetest/custom_widgets/container/non_veg_container.dart';
import 'package:machinetest/custom_widgets/container/veg_container.dart';
import 'package:machinetest/custom_widgets/dish_details/dish_details.dart';
import 'package:machinetest/controller/counter_provider.dart';
import 'package:machinetest/model/restaurent_model.dart';
import 'package:machinetest/view/Tab_1/widgets/counter_widget.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

class OrderDetailContainer extends StatelessWidget {
  const OrderDetailContainer({
    super.key,
    required this.dish,
  });
  final CategoryDish dish;

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    final count = counterProvider.dishCounts[dish.dishId] ?? 0;
    final dishtotal = (dish.dishPrice * count);

    return Padding(
      padding: EdgeInsets.all(3.sp),
      child: SizedBox(
        height: 80.sp,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 1.sp,
                    ),
                    if (dish.dishType == 1)
                      const NonVegContainer()
                    else
                      const VegContainer()
                  ],
                ),
                SizedBox(
                  width: 7.sp,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: 90.sp,
                        child: DishName(
                          dishName: dish.dishName,
                        )),
                    SizedBox(
                      height: 4.sp,
                    ),
                    DishPrice(
                      dishPrice: dish.dishPrice,
                    ),
                    SizedBox(
                      height: 4.sp,
                    ),
                    DishCalorie(calorie: dish.dishCalories.toString()),
                  ],
                ),
                CounterWidget(
                  color: const Color.fromARGB(255, 6, 66, 8),
                  dishId: dish.dishId,
                  dishlist: dish,
                ),
                SizedBox(
                  width: 2.sp,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 6.sp,
                    ),
                    DishPrice(
                      dishPrice: dishtotal,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
