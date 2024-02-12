import 'package:flutter/material.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/model/restaurent_model.dart';
import 'package:machinetest/view/Tab_1/view/food_detail_container.dart';
import 'package:provider/provider.dart';

class FoodList extends StatelessWidget {
  const FoodList({super.key, required this.categoryDishes});
  final List<CategoryDish> categoryDishes;
  @override
  Widget build(BuildContext context) {
    return Consumer<DishListController>(
      builder: (context, value, child) => ListView.separated(
        itemBuilder: (context, index) {
          return FoodDetailContainer(cateDish: categoryDishes[index]);
        },
        itemCount: categoryDishes.length,
        separatorBuilder: (context, index) => const Divider(
          color: Color.fromARGB(255, 175, 175, 175),
        ),
      ),
    );
  }
}
