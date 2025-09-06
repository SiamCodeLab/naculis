import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../quiz/screens/quiz_screen.dart';
import '../../quiz/screens/result_screen.dart';
import '../screens/game_level_screen.dart';
import '../screens/greetings_intro_screen.dart';
import '../screens/progress_screen.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final navigatorState = Get.nestedKey(NavIds.home)?.currentState;

        if (navigatorState != null && navigatorState.canPop()) {
          navigatorState.pop();
          return false;
        }
        return true;
      },
      child: Navigator(
        key: Get.nestedKey(NavIds.home),
        initialRoute: RouteName.gameLevel,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouteName.gameLevel:
              return MaterialPageRoute(builder: (_) => const GameLevelScreen());
            case RouteName.gameProgress:
              return MaterialPageRoute(builder: (_) => const ProgressScreen());
            case RouteName.greetingsAndIntro:
              return MaterialPageRoute(builder: (_) => const GreetingsIntroScreen());
            case RouteName.quiz:
              return MaterialPageRoute(builder: (_) => const QuizScreen());
            case RouteName.quizResult:
              return MaterialPageRoute(builder: (_) => const ResultScreen());
            default:
              return null;
          }
        },
      ),
    );
  }
}
