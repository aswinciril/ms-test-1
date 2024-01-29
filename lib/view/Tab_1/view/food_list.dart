import 'package:flutter/material.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/view/Tab_1/view/food_detail_container.dart';
import 'package:provider/provider.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DishListController>(
      builder: (context, value, child) => ListView.separated(
        itemBuilder: (context, index) {
          return FoodDetailContainer(dishlist: value.dishmodelList[index]);
        },
        itemCount: value.dishmodelList.length,
        separatorBuilder: (context, index) => Divider(
          color: const Color.fromARGB(255, 175, 175, 175),
        ),
      ),
    );
  }
}
