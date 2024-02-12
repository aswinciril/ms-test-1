import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:machinetest/core/constants.dart';
// import 'package:machinetest/model/dish_model.dart';
import 'package:machinetest/model/restaurent_model.dart';
import 'package:machinetest/service/api_service.dart';

class DishListController extends ChangeNotifier {
  // List<DishListModel> dishmodelList = [];
  List<RestaurantModel> listRestaurentModel = [];
  RestaurantModel? restaurentmodel;
  List<TableMenuList>? tableMenuList = [];
  final NetworkApiService apiService = NetworkApiService();
  bool isloading = false;
  // DishModel dishModel = DishModel(); /
  // Future<void> getDishesData() async {
  //   final Response? response =
  //       await apiService.getDishList(ApiEndPoints.baseUrl);
  //   log("Data called ");
  //   Map<String, dynamic> data = response!.data[0];

  //   for (var dishList in data["table_menu_list"][0]["category_dishes"]) {
  //     final list = DishListModel.fromJson(dishList);
  //     dishmodelList.add(list);
  //   }

  //   log(dishmodelList.toString());
  // }

//new
  Future<void> getRestaurentData() async {
    tableMenuList?.clear();
    isloading = true;
    notifyListeners();

    final response = await apiService.getDishList(ApiEndPoints.baseUrl);
    log("FETCHED DATA :-------> $response");

    if (response != null) {
      // Assuming response.data is a list of JSON objects representing restaurants
      List<dynamic> responseData = response.data;
      listRestaurentModel =
          responseData.map((json) => RestaurantModel.fromJson(json)).toList();
      if (listRestaurentModel.isNotEmpty) {
        restaurentmodel = listRestaurentModel[0];
        log("data in model is ---> ${restaurentmodel?.restaurantName}");
      }
    }

    isloading = false;
    notifyListeners();
  }

  void resetState() {
    // dishmodelList.clear();

    // Notify listeners to rebuild widgets that depend on this controller
    notifyListeners();
  }
}
