import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';
import '../../home/controller/home_controller.dart';
import '../../user_profile/user_profile_controller/profile_controller.dart';

class SplashLoadingScreen extends StatefulWidget {
  const SplashLoadingScreen({super.key});

  @override
  State<SplashLoadingScreen> createState() => _SplashLoadingScreenState();
}

class _SplashLoadingScreenState extends State<SplashLoadingScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        print('Checking login status...');
        bool isLoggedIn = await UserInfo.getIsLoggedIn();
        print('Is logged in: $isLoggedIn');

        if (isLoggedIn) {
          print('Navigating to home...');
          Get.offAllNamed(RouteName.home);
        } else {
          print('Navigating to langSplash...');
          Get.offAllNamed(RouteName.langSplash);
        }
      } catch (e) {
        print('Error in splash navigation: $e');
        // error paileo jeno langSplash e jay,, pore change kore nio eta
        Get.offAllNamed(RouteName.langSplash);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/bg/splash_bg.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(width: 300, 'assets/images/logo.png'),
                  SizedBox(height: Get.height * 0.04),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: 0.7,
                          strokeWidth: 6,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white70,
                          ),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      Text(
                        '70%',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
