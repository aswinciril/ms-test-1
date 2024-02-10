import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/core/constants.dart';
import 'package:machinetest/model/dish_model.dart';
import 'package:machinetest/model/restaurent_model.dart';
import 'package:machinetest/service/api_service.dart';

class DishListController extends ChangeNotifier {
  List<DishListModel> dishmodelList = [];
  List<RestaurantModel> restaurentmodelList = [];
  final NetworkApiService apiService = NetworkApiService();
  // DishModel dishModel = DishModel();
  Future<void> getDishesData() async {
    final Response? response =
        await apiService.getDishList(ApiEndPoints.baseUrl);
    log("Data called ");
    Map<String, dynamic> data = response!.data[0];

    for (var dishList in data["table_menu_list"][0]["category_dishes"]) {
      final list = DishListModel.fromJson(dishList);
      dishmodelList.add(list);
    }

    log(dishmodelList.toString());
  }

//new
  Future<List<RestaurantModel>> getRestaurentData() async {
    final Response? response =
        await apiService.getDishList(ApiEndPoints.baseUrl);
    log("Data called ");
    if (response != null) {
      for (var restoModel in response.data) {
        final data = RestaurantModel.fromJson(restoModel);
        restaurentmodelList.add(data);
        log(restaurentmodelList.toString());
      }

      // final json = jsonDecode(response.data);
    }
    return restaurentmodelList;
  }

  void resetState() {
    dishmodelList.clear();

    // Notify listeners to rebuild widgets that depend on this controller
    notifyListeners();
  }
}
