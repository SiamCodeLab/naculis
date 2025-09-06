import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/profile_app_bar.dart';

class ShopScreen5 extends StatelessWidget {
  const ShopScreen5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
          onBackPressed: () => Get.back(id: NavIds.shop),
          title: "Payment Method"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Successfully Paid",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),

            Image.asset(
              'assets/images/creditCard.png',
              // replace with your actual asset
              height: 250,
            ),

            Text(
              'You have successfully signed up for Business user. Let’s setup your Business now',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
            ),

            // Finish button
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            Get.toNamed(RouteName.shop1, id: NavIds.shop);
          },
          child: const Text(
            'Finish',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
