import 'package:flutter/material.dart';
import 'package:machinetest/controller/counter_provider.dart';
import 'package:machinetest/model/restaurent_model.dart';
import 'package:machinetest/view/order_page/view/order_detail_container.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) {
        // Create a set to store unique dish IDs
        Set<String> uniqueDishIds = {};

        // Filter selectedDishes based on count
        List<CategoryDish> filteredDishes = counterProvider.selectedDishes
            .where((dish) => counterProvider.dishCounts[dish.dishId] != 0)
            .toList();

        return ListView.separated(
          itemBuilder: (context, index) {
            // Get the dish from filteredDishes
            CategoryDish dish = filteredDishes[index];

            // Check if the dishId is already added to the uniqueDishIds set
            if (uniqueDishIds.contains(dish.dishId)) {
              // Dish with this dishId already added, return an empty container
              return Container();
            } else {
              // Add the dishId to the set
              uniqueDishIds.add(dish.dishId);
              // Display the OrderDetailContainer for this dish

              return OrderDetailContainer(dish: dish);
            }
          },
          itemCount: filteredDishes.length,
          separatorBuilder: (context, index) {
            // Check if the current dishId is the same as the next dishId
            if (index < filteredDishes.length - 1) {
              String currentDishId = filteredDishes[index].dishId;
              String nextDishId = filteredDishes[index + 1].dishId;

              // If the dishIds are the same, return an empty container to skip rendering the separator
              if (currentDishId == nextDishId) {
                return Container();
              }
            }

            // Render the separator
            return const Divider(
              color: Color.fromARGB(255, 175, 175, 175),
            );
          },
        );
      },
    );
  }
}
