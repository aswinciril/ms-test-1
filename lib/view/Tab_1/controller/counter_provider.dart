import 'package:flutter/material.dart';
import 'package:machinetest/model/dish_model.dart';

class CounterProvider extends ChangeNotifier {
  final Map<String, int> dishCounts = {};
  List<DishListModel> selectedDishes = []; // Map to store dish IDs and counts
  DishListModel? currentDish;

  double get totalDishSum => _calculateTotalDishSum();

  double _calculateTotalDishSum() {
    double sum = 0;
    for (var entry in dishCounts.entries) {
      final dishId = entry.key;
      final count = entry.value;
      final dish = selectedDishes.firstWhere(
        (dish) => dish.dishId == dishId,
        orElse: () => DishListModel(
          dishImage: "", dishCurrency: "", dishDescription: "",
          dishAvailability: false,
          dishId: dishId,
          // Provide default values if the dish is not found
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

  // Methods to increment/decrement counts based on dish ID
  void incrementCount(String dishId) {
    dishCounts[dishId] = (dishCounts[dishId] ?? 0) + 1;
    if (dishCounts[dishId] == 0) {
      // Add dish to orderedDishes
    }
    notifyListeners();
  }

  void decrementCount(String dishId) {
    if (dishCounts[dishId] != null && dishCounts[dishId]! > 0) {
      dishCounts[dishId] = (dishCounts[dishId] ?? 0) - 1;
      notifyListeners();
    }
  }

  void incrementDish(DishListModel dish) {
    // Update dish count and store the current dish
    currentDish = dish;
    notifyListeners(); // Notify listeners of changes
  }

  int get totalCount {
    // Calculate the total count based on your logic (e.g., summing individual dish counts)
    return dishCounts.values.fold(0, (sum, count) => sum + count);
  }

  void addToSelectedDishes(DishListModel dish) {
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
