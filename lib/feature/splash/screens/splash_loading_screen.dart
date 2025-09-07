import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/core/const/image_icon.dart';

import '../../../core/local_storage/user_info.dart';
import '../../../routes/route_name.dart';

class SplashLoadingScreen extends StatefulWidget {
  const SplashLoadingScreen({super.key});

  @override
  State<SplashLoadingScreen> createState() => _SplashLoadingScreenState();
}

class _SplashLoadingScreenState extends State<SplashLoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Controller runs for 3 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Animate from 0 -> 1
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // Navigation after animation is done
    Future.delayed(const Duration(seconds: 3), () async {
      try {
        bool isLoggedIn = await UserInfo.getIsLoggedIn();
        if (isLoggedIn) {
          Get.offAllNamed(RouteName.home);
        } else {
          Get.offAllNamed(RouteName.langSplash);
        }
      } catch (e) {
        Get.offAllNamed(RouteName.langSplash);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                image: const AssetImage(ImageAndIconConst.splashBg),
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
                children: [
                  Image.asset(width: 300, ImageAndIconConst.logoW),
                  SizedBox(height: Get.height * 0.04),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(
                              value: _animation.value,
                              strokeWidth: 6,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white70,
                              ),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                          Text(
                            "${(_animation.value * 100).toInt()}%",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      );
                    },
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
