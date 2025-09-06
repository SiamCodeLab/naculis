import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:naculis/feature/home/controller/home_controller.dart';
import 'package:naculis/feature/quest/navigator/quest_navigator.dart';
import 'package:naculis/feature/shop/shop_navigator/shop_navigator.dart';
import 'package:naculis/feature/speak/screens/chat_with_bot.dart';
import 'package:naculis/feature/user_profile/navigator/profile_navigator.dart';
import 'package:naculis/feature/widgets/custom_nav_bar.dart';

import 'home/navigator/home_navigator.dart';
import 'leader_board/screens/leader_board_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final controller = Get.put(LevelsController());

  @override
  void initState() {
    super.initState();
    controller.levelList();
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    6,
    (index) => GlobalKey<NavigatorState>(),
  );

  final List<Widget> _screens = [
    HomeNavigator(),
    ChatWithBotScreen(),
    LeaderBoardScreen(),
    QuestNavigator(),
    ShopNavigator(),
    ProfileNavigator(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: CustomNavbar(
        onItemSelected: (index) {
          if (_currentIndex == index) {
            // Optional: pop to first screen when the same tab is tapped again
            _navigatorKeys[index].currentState?.popUntil(
              (route) => route.isFirst,
            );
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
