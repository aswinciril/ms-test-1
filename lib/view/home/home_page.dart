import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:machinetest/controller/dish_controller.dart';
import 'package:machinetest/controller/counter_provider.dart';
import 'package:machinetest/model/restaurent_model.dart';
import 'package:machinetest/view/Tab_1/view/food_list.dart';
import 'package:machinetest/view/home/userlogout.dart';
import 'package:machinetest/view/order_page/view/order_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> _fetchData;
  User? _user;
  @override
  void initState() {
    super.initState();
    _fetchData = fetchData();
  }

  Future<void> fetchData() async {
    final dishProvider =
        Provider.of<DishListController>(context, listen: false);
    await dishProvider.getDishesData();
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = currentUser;
    });
    dishProvider.getRestaurentData(); //TODO
  }

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);
    Set<String> uniqueDishIds = {};

    // Iterate through selectedDishes to count unique dishes
    for (var dish in counterProvider.selectedDishes) {
      uniqueDishIds.add(dish.dishId);
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                    "${uniqueDishIds.length}", // Display total count
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
            tabs: [
              Tab(
                text: "Salads and Soups",
              ),
              // Tab(text: widget.tablelist!.menuCategory),
              Tab(
                text: "From the Banyard",
              ),
              Tab(
                text: "From the",
              ),
            ],
            indicatorColor: Color.fromARGB(255, 240, 107, 98),
            labelColor: Color.fromARGB(255, 240, 107, 98),
          ),
        ),
        drawer: Drawer(
          width: 270.sp,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 63, 156, 66),
                      Color.fromARGB(255, 33, 243, 100),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                height: 190.sp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.sp,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          const AssetImage("assets/images/dishdp.jpg"),
                      radius: 40.sp,
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      _getUserDisplayName(),
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 3.sp,
                    ),
                    Text(
                      "ID : ${_user?.uid.substring(0, 4) ?? 'Guest'}",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text("Log out"),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const UserLogout();
                      });
                },
              )
            ],
          ),
        ),
        body: FutureBuilder(
          future: _fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data'),
              );
            } else {
              return const TabBarView(
                children: [
                  FoodList(),
                  Center(
                    child: Text("tab2"),
                  ),
                  Center(
                    child: Text("tab3"),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  // Function to get the user display name or phone number
  String _getUserDisplayName() {
    if (_user != null) {
      // If user is logged in
      if (_user!.displayName != null && _user!.displayName!.isNotEmpty) {
        // If the user has a display name (Google sign-in)
        return _user!.displayName!;
      } else if (_user!.phoneNumber != null && _user!.phoneNumber!.isNotEmpty) {
        // If the user has a phone number (Phone OTP sign-in)
        return _user!.phoneNumber!;
      }
    }
    // Default value if no user is logged in or no display name/phone number available
    return "Guest User";
  }
}
