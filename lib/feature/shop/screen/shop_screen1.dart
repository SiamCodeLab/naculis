import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_string.dart';
import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../widgets/custom_appbar.dart';
import 'controller/heart_controller.dart';
import 'controller/subscribe_controller.dart';

class ShopScreen1 extends StatelessWidget {
  const ShopScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HeartController(),permanent: true);
    final shopSubController = Get.put(ShopSubscriptionController(),permanent: true);
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () =>  _buildCard(
                  icon: Icons.diamond,
                  title: '${controller.controller.user.value.gem }',
                  subtitle: AppStringEn.gemsAvailable.tr,
                  buttonText: AppStringEn.exchange.tr,
                  buttonColor: Theme.of(context).colorScheme.secondary,
                  titleStyle: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                  ),
                  subtitleStyle: const TextStyle(
                    color: Color(0xFFF57C00),
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    controller.exchangeGems();
                    Get.toNamed(RouteName.shop2, id: NavIds.shop);
                  },
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                    () => _buildCard(

                  icon: Icons.favorite_border,
                  title: AppStringEn.heartRecharge.tr,
                  subtitle: controller.heartsData.value['current_hearts'] == controller.heartsData.value['max_hearts']
                      ? AppStringEn.heartsFull.tr
                      : '${controller.heartsData.value['current_hearts']} / ${controller.heartsData.value['max_hearts']}',
                  footerText: controller.heartsData.value['current_hearts'] == controller.heartsData.value['max_hearts']
                      ? Text(
                    AppStringEn.heartsFull.tr,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                      : SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,spacing: 10,
                      children: [
                        Expanded( // Wrap in Expanded to constrain size
                          child: ElevatedButton(
                            onPressed: controller.refillAllHeart,
                            child: Text('Refill All Hearts',style: TextStyle(fontSize: 15,color: Colors.white),),
                          ),
                        ),
                        Expanded( // Wrap in Expanded to constrain size
                          child: ElevatedButton(
                            onPressed: controller.refillOneHeart,
                            child:  Text('Refill One Heart',style: TextStyle(fontSize: 15,color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  footerColor: Theme.of(context).colorScheme.secondary,
                  titleStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                  ),
                  subtitleStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    Get.toNamed(RouteName.shop2, id: NavIds.shop);
                  },
                ),
              ),

              const SizedBox(height: 16),
              _buildCard(
                icon: Icons.crop_outlined,
                title: AppStringEn.premiumSubscription.tr,
                subtitle: AppStringEn.removeAdsUnlockPremium.tr,
                price: '\$5.99\nPer month',
                buttonText: AppStringEn.subscribe.tr,
                buttonColor: Theme.of(context).colorScheme.secondary,
                badgeText: AppStringEn.popular.tr,
                titleStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF57C00),
                ),
                subtitleStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
                onPressed: () {
                  shopSubController.startSubscription();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? footerText,
    Color? footerColor,
    String? buttonText,
    Color? buttonColor,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    String? price,
    String? badgeText,
    required VoidCallback onPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5E7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFE0B2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (badgeText != null)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF57C00),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          Row(
            children: [
              Icon(icon, color: const Color(0xFFF57C00), size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: titleStyle ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: subtitleStyle ?? const TextStyle(fontSize: 30, color: Colors.black54),
            overflow: TextOverflow.ellipsis, // Prevent text overflow
          ),
          if (footerText != null) ...[
            const SizedBox(height: 10),
            footerText,
          ],
          if (price != null) ...[
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
          if (buttonText != null && buttonColor != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
