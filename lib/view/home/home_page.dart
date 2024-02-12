import 'package:flutter/material.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/controller/counter_provider.dart';
import 'package:machinetest/controller/google_controller.dart';
import 'package:machinetest/custom_widgets/drawer/custom_drawer.dart';
import 'package:machinetest/model/restaurent_model.dart';
import 'package:machinetest/view/Tab_1/view/food_list.dart';
import 'package:machinetest/view/order_page/view/order_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RestaurantModel>? restaurentmodelList;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DishListController>().getRestaurentData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    final googleProvider = Provider.of<GoogleProvider>(context);
    Set<String> uniqueDishIds = {};

    // Iterate through selectedDishes to count unique dishes
    for (var dish in counterProvider.selectedDishes) {
      uniqueDishIds.add(dish.dishId);
    }

    return Consumer<DishListController>(
      builder: (context, value, child) => DefaultTabController(
        length: value.restaurentmodel?.tableMenuList.length ?? 0,
        child: (value.isloading)
            ? const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  actions: [
                    Stack(children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OrderPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_cart,
                          size: 30,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            "${uniqueDishIds.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ]),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: List.generate(
                        value.restaurentmodel?.tableMenuList.length ?? 0,
                        (index) {
                      return Tab(
                        text: value
                            .restaurentmodel?.tableMenuList[index].menuCategory,
                      );
                    }),
                    indicatorColor: const Color.fromARGB(255, 240, 107, 98),
                    labelColor: const Color.fromARGB(255, 240, 107, 98),
                  ),
                ),
                drawer: CustomDrawer(
                  getUserDisplayName: googleProvider.getUserDisplayName,
                ),
                body: TabBarView(
                  children: List.generate(
                      value.restaurentmodel?.tableMenuList.length ?? 0,
                      (index) {
                    return FoodList(
                        categoryDishes: value.restaurentmodel!
                            .tableMenuList[index].categoryDishes);
                  }),
                ),
              ),
      ),
    );
  }
}
