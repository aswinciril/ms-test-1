// import 'dart:convert';

// List<DishListModel> dishListModelFromJson(String str) =>
//     List<DishListModel>.from(
//         json.decode(str).map((x) => DishListModel.fromJson(x)));

// String dishListModelToJson(List<DishListModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class AddonCat {
//   String addonCategory;
//   String addonCategoryId;
//   int addonSelection;
//   String nexturl;
//   List<DishListModel> addons;

//   AddonCat({
//     required this.addonCategory,
//     required this.addonCategoryId,
//     required this.addonSelection,
//     required this.nexturl,
//     required this.addons,
//   });

//   factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
//         addonCategory: json["addon_category"],
//         addonCategoryId: json["addon_category_id"],
//         addonSelection: json["addon_selection"],
//         nexturl: json["nexturl"],
//         addons: List<DishListModel>.from(
//             json["addons"].map((x) => DishListModel.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "addon_category": addonCategory,
//         "addon_category_id": addonCategoryId,
//         "addon_selection": addonSelection,
//         "nexturl": nexturl,
//         "addons": List<dynamic>.from(addons.map((x) => x.toJson())),
//       };
// }

// class DishListModel {
//   String dishId;
//   String dishName;
//   double dishPrice;
//   String dishImage;
//   String dishCurrency;
//   num dishCalories;
//   String dishDescription;
//   bool dishAvailability;
//   int dishType;
//   String? nexturl;
//   List<AddonCat>? addonCat;

//   DishListModel({
//     required this.dishId,
//     required this.dishName,
//     required this.dishPrice,
//     required this.dishImage,
//     required this.dishCurrency,
//     required this.dishCalories,
//     required this.dishDescription,
//     required this.dishAvailability,
//     required this.dishType,
//     this.nexturl,
//     this.addonCat,
//   });

//   factory DishListModel.fromJson(Map<String, dynamic> json) => DishListModel(
//         dishId: json["dish_id"],
//         dishName: json["dish_name"],
//         dishPrice: json["dish_price"]?.toDouble(),
//         dishImage: json["dish_image"],
//         dishCurrency: json["dish_currency"],
//         dishCalories: json["dish_calories"],
//         dishDescription: json["dish_description"],
//         dishAvailability: json["dish_Availability"],
//         dishType: json["dish_Type"],
//         nexturl: json["nexturl"],
//         addonCat: json["addonCat"] == null
//             ? []
//             : List<AddonCat>.from(
//                 json["addonCat"]!.map((x) => AddonCat.fromJson(x))),
//       );

//   get count => null;

//   Map<String, dynamic> toJson() => {
//         "dish_id": dishId,
//         "dish_name": dishName,
//         "dish_price": dishPrice,
//         "dish_image": dishImage,
//         "dish_currency": dishCurrency,
//         "dish_calories": dishCalories,
//         "dish_description": dishDescription,
//         "dish_Availability": dishAvailability,
//         "dish_Type": dishType,
//         "nexturl": nexturl,
//         "addonCat": addonCat == null
//             ? []
//             : List<dynamic>.from(addonCat!.map((x) => x.toJson())),
//       };
// }
