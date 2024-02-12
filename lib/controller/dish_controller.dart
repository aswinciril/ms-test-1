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
    notifyListeners();
  }
}
