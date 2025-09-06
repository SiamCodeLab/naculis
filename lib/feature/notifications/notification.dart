import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/const/app_string.dart';
import '../../core/const/nav_ids.dart';
import '../widgets/profile_app_bar.dart';
import 'controller/ notification_controller.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController(),permanent: true);

    return Scaffold(
      appBar: ProfileAppBar(
        onBackPressed: () => Get.back(id: NavIds.profile),
        title: AppStringEn.Notifications.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(() {
          // If loading, show loading indicator
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          // If no notifications
          if (controller.notificationsResponse.value.isEmpty) {
            return Center(child: Text('No notifications available.', style: Theme.of(context).textTheme.titleMedium));
          }

          return ListView.builder(
            itemCount: controller.notificationsResponse.value['results']['notifications'].length,
            itemBuilder: (context, index) {
              var notification = controller.notificationsResponse.value['results']['notifications'][index];

              return notificationCard(
                icon: Icons.notifications,
                iconColor: Theme.of(context).primaryColor,
                title: notification['title'] ?? 'Notification Title',
                subtitle: notification['message'] ?? 'No message available',
              );
            },
          );
        }),
      ),

      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(),
        onPressed: () {
          Get.defaultDialog(
            title: "Delete All Notifications",
            content: SizedBox(
             // Adjust height as needed
              width: 400, // Or a fixed width
              child: Column(
                mainAxisSize: MainAxisSize.min, // Prevent taking infinite height
                children: [
                  const SizedBox(height: 10),
                  Text(style: TextStyle(color:Colors.black, fontSize: 16),
                    'Are you sure you want to delete all notifications?',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {
                            controller.deleteAllNotifications();
                            Get.back();
                          },
                          child: const Text('Yes', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () => Get.back(),
                          child: const Text('No', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),


    );
  }

  // Notification item
  Widget notificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7E7), // Soft card color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
