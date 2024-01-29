import 'package:flutter/material.dart';
import 'package:machinetest/model/dish_model.dart';
import 'package:machinetest/view/Tab_1/controller/counter_provider.dart';
import 'package:machinetest/view/order_page/view/order_detail_container.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CounterProvider>(
      builder: (context, counterProvider, child) {
        // Create a set to store unique dish IDs
        Set<String> uniqueDishIds = {};

        return ListView.separated(
          itemBuilder: (context, index) {
            // Get the dish from selectedDishes
            DishListModel dish = counterProvider.selectedDishes[index];

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
          itemCount: uniqueDishIds.length,
          separatorBuilder: (context, index) => Divider(
            color: const Color.fromARGB(255, 175, 175, 175),
          ),
        );
      },
    );
  }
}
