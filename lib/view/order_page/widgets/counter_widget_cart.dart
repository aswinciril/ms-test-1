import 'package:flutter/material.dart';
import 'package:machinetest/view/Tab_1/controller/cart_counter_provider.dart';
import 'package:machinetest/view/Tab_1/widgets/counter_text.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class CounterWidgetCart extends StatelessWidget {
  const CounterWidgetCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 77.sp,
      height: 30.sp,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 6, 66, 8),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              final counterProvider =
                  Provider.of<CartCountProvider>(context, listen: false);

              counterProvider.decrement();
            },
            child: CounterText(
              text: "-",
            ),
          ),
          Consumer<CartCountProvider>(
            builder: (context, counterProvider, child) {
              return CounterText(text: "${counterProvider.cartCount}");
            },
          ),
          GestureDetector(
            onTap: () {
              final counterProvider = Provider.of<CartCountProvider>(
                context,
                listen: false,
              );

              counterProvider.increment();
            },
            child: CounterText(text: "+"),
          ),
        ],
      ),
    );
  }
}
