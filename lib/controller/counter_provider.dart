import 'package:flutter/material.dart';
import 'package:machinetest/model/restaurent_model.dart';

class CounterProvider extends ChangeNotifier {
  final Map<String, int> dishCounts = {};
  List<CategoryDish> selectedDishes = [];
  CategoryDish? currentDish;

  double get totalDishSum => _calculateTotalDishSum();

  double _calculateTotalDishSum() {
    double sum = 0;
    for (var entry in dishCounts.entries) {
      final dishId = entry.key;
      final count = entry.value;
      final dish = selectedDishes.firstWhere(
        (dish) => dish.dishId == dishId,
        orElse: () => CategoryDish(
          dishImage: "",
          dishCurrency: "",
          dishDescription: "",
          dishAvailability: false,
          dishId: dishId,
          dishName: '',
          dishPrice: 0,
          dishCalories: 0,
          dishType: 0,
        ),
      );

      sum += dish.dishPrice * count;
    }

    return sum;
  }

  void incrementCount(String dishId) {
    dishCounts[dishId] = (dishCounts[dishId] ?? 0) + 1;
    if (dishCounts[dishId] == 0) {}
    notifyListeners();
  }

  void decrementCount(String dishId) {
    if (dishCounts[dishId] != null && dishCounts[dishId]! > 0) {
      dishCounts[dishId] = (dishCounts[dishId] ?? 0) - 1;
      if (dishCounts[dishId] == 0) {
        removeFromSelectedDishes(dishId);
      }
      notifyListeners();
    }
  }

  void incrementDish(CategoryDish dish) {
    currentDish = dish;
    notifyListeners();
  }

  int get totalCount {
    return dishCounts.values.fold(0, (sum, count) => sum + count);
  }

  void addToSelectedDishes(CategoryDish dish) {
    selectedDishes.add(dish);
    notifyListeners();
  }

  void removeFromSelectedDishes(String dishIdToRemove) {
    print('Selected Dishes before removal: $selectedDishes');
    selectedDishes.removeWhere((dish) => dishIdToRemove == dish.dishId);
    print('Selected Dishes after removal: $selectedDishes');
    notifyListeners();
  }

  void clearCart() {
    dishCounts.clear();
    selectedDishes.clear();
    notifyListeners();
  }
}
