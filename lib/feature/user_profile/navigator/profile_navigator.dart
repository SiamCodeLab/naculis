import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../contact_refer/contact_us.dart';
import '../../contact_refer/refer_a_friend.dart';
import '../../notifications/notification.dart';
import '../../withdarw/withdarw.dart';
import '../screens/edit_profile_screen.dart';
import '../screens/personal_info_screen.dart';
import '../screens/profile_screen.dart';

class ProfileNavigator extends StatelessWidget {
  const ProfileNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final canPop = Get.nestedKey(NavIds.profile)?.currentState?.canPop() ?? false;
        if (canPop) {
          Get.nestedKey(NavIds.profile)?.currentState?.pop();
          return false;
        }
        return true;
      },
      child: Navigator(
        key: Get.nestedKey(NavIds.profile),
        initialRoute: RouteName.userProfile,
        onGenerateRoute: (settings) {
          if(settings.name==RouteName.userProfile){
            return MaterialPageRoute(builder: (context) => const ProfileScreen(),);
          }else if(settings.name==RouteName.userProfileEdit){
            return MaterialPageRoute(builder: (context) =>  EditProfileScreen(),);
          }else if(settings.name==RouteName.personalInfo){
            return MaterialPageRoute(builder: (context) => const PersonalInfoScreen(),);
          }else if(settings.name==RouteName.withdraw){
            return MaterialPageRoute(builder: (context) => const Withdarw(),);
          }else if (settings.name==RouteName.referFriend){
            return MaterialPageRoute(builder: (context) => const ReferFriend(),);
          }else if (settings.name==RouteName.contactUs){
            return MaterialPageRoute(builder: (context) => const ContactUs(),);
          }else if(settings.name==RouteName.notification){
            return MaterialPageRoute(builder: (context) => const NotificationsScreen(),);
          }


          return null;
        },
      ),
    );
  }
}
