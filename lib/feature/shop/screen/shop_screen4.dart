import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/profile_app_bar.dart';

class ShopScreen4 extends StatefulWidget {
  const ShopScreen4({super.key});

  @override
  State<ShopScreen4> createState() => _ShopScreen4State();
}

class _ShopScreen4State extends State<ShopScreen4> {
  bool saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Light peach background
      appBar: ProfileAppBar(
          onBackPressed: () => Get.back(id: NavIds.shop),
          title: 'Payment Method'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Card Information',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Theme.of(context).colorScheme.tertiaryFixed,
              ),
            ),
            const SizedBox(height: 12),

            // Card Image
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/image 2355.png',
                  // Replace with your card asset path
                  fit: BoxFit.cover,
                  height: 208.01,
                  width: 330,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Card Number
            const TextFieldLabel('Card Number',),
            customInputField(),

            const SizedBox(height: 10),
            const TextFieldLabel('Card Holder Name'),
            customInputField(),

            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldLabel('Expire on'),
                      customInputField(),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextFieldLabel('CVV Number'),
                      customInputField(),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: saveCard,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) {
                    setState(() {
                      saveCard = value!;
                    });
                  },
                ),
                Text(
                  'Save this card for future',
                  style: TextStyle(color:Theme.of(context).colorScheme.tertiaryFixed, fontSize: 18),
                ),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(RouteName.shop5,id:NavIds.shop);
                },
                child: const Text(
                  'Process to Payment',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customInputField() {
    return TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class TextFieldLabel extends StatelessWidget {
  final String text;

  const TextFieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:  TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Theme.of(context).colorScheme.tertiaryFixed,
      ),
    );
  }
}
