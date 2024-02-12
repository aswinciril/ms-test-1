import 'package:flutter/material.dart';
import 'package:machinetest/custom_widgets/Buttons/custom_button.dart';
import 'package:machinetest/controller/counter_provider.dart';
import 'package:machinetest/view/order_page/view/order_list.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final counterProvider = Provider.of<CounterProvider>(context);

    Set<String> uniqueDishIds = {};

    // Iterate through selectedDishes to count unique dishes
    for (var dish in counterProvider.selectedDishes) {
      uniqueDishIds.add(dish.dishId);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Order Summary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(15.sp),
              child: Container(
                height: 410.sp,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(255, 219, 216, 216),
                    width: 1.5.sp,
                  ),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 330.sp,
                      child: Stack(
                        children: [
                          // Container above OrderList
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 40.sp,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 6, 66, 8),
                                borderRadius: BorderRadius.circular(8.sp),
                              ),
                              child: Center(
                                child: Text(
                                  "${uniqueDishIds.length} Dishes - ${counterProvider.totalCount} Items",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 40.sp,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Padding(
                              padding: EdgeInsets.all(2.sp),
                              child: const OrderList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 175, 175, 175),
                    ),
                    SizedBox(
                      height: 9.sp,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "INR :${counterProvider.totalDishSum}",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 54, 123, 56),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.sp),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            counterProvider.clearCart();
                          },
                          child: const Text(
                            "Clear Cart",
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  CustomButton(
                    onpressed: () {
                      Fluttertoast.showToast(
                        msg: "Order placed successfully!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        webShowClose: false,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      counterProvider
                          .clearCart(); // if need to clear cart after placing order
                    },
                    width: 5,
                    primarycolor: const Color.fromARGB(255, 6, 66, 8),
                    onprimarycolor: const Color.fromARGB(255, 255, 255, 255),
                    title: "Place Order",
                    fontweight: FontWeight.w700,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
