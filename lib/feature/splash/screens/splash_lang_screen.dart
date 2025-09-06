import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_name.dart';
import '../widgets/langauge_card.dart';

class SplashLangScreen extends StatefulWidget {
  const SplashLangScreen({super.key});

  @override
  State<SplashLangScreen> createState() => _SplashLangScreenState();
}

class _SplashLangScreenState extends State<SplashLangScreen> {
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
                  Text(
                    'Choose Your Language',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Elige tu idioma',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: Get.height * 0.04),

                  LanguageCard(
                    title: 'US English',
                    subTitle: 'What \'s good? Welcome to Naculis',
                    onPress: () {
                      Get.offNamed(RouteName.signin);
                    },
                  ),

                  SizedBox(height: Get.height * 0.03),

                  LanguageCard(
                    title: 'Español',
                    subTitle: '"¿Qué onda? Bienvenido a Naculis',
                    onPress: () {
                      Get.updateLocale(const Locale('es', 'ES'));
                      Get.offNamed(RouteName.signin);
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
