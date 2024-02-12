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
        Set<String> uniqueDishIds = {};

        List<CategoryDish> filteredDishes = counterProvider.selectedDishes
            .where((dish) => counterProvider.dishCounts[dish.dishId] != 0)
            .toList();

        return ListView.separated(
          itemBuilder: (context, index) {
            CategoryDish dish = filteredDishes[index];

            if (uniqueDishIds.contains(dish.dishId)) {
              return Container();
            } else {
              uniqueDishIds.add(dish.dishId);
              return OrderDetailContainer(dish: dish);
            }
          },
          itemCount: filteredDishes.length,
          separatorBuilder: (context, index) {
            if (index < filteredDishes.length - 1) {
              String currentDishId = filteredDishes[index].dishId;
              String nextDishId = filteredDishes[index + 1].dishId;

              if (currentDishId == nextDishId) {
                return Container();
              }
            }

            return const Divider(
              color: Color.fromARGB(255, 175, 175, 175),
            );
          },
        );
      },
    );
  }
}
