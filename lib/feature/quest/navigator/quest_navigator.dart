// quest_navigator.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/nav_ids.dart';
import '../../../routes/route_name.dart';
import '../../quiz/screens/auto_tracked_quest_question.dart';
import '../quest.dart';
import '../widgets/auto_tracked_quest.dart';
import '../widgets/lesson_quest.dart';

class QuestNavigator extends StatelessWidget {
  const QuestNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final nestedKey = Get.nestedKey(NavIds.quest);

    return WillPopScope(
      onWillPop: () async {
        // Check if nested navigator exists and can pop
        if (nestedKey != null &&
            nestedKey.currentState != null &&
            nestedKey.currentState!.canPop()) {
          nestedKey.currentState!.pop();
          return false; // prevent parent pop
        }
        return true; // allow default pop
      },
      child: Navigator(
        key: nestedKey,
        initialRoute: RouteName.quest,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouteName.quest:
              return MaterialPageRoute(builder: (_) => const QuestScreen());
            case RouteName.lessonQuest:
              return MaterialPageRoute(builder: (_) => const LessonQuest());
            case RouteName.autoTracked:
              return MaterialPageRoute(builder: (_) => Auto_Tracked());
            case RouteName.questQuestion:
              return MaterialPageRoute(
                  builder: (_) => const AutoTrackedQuestQuestion());
            default:
              return MaterialPageRoute(builder: (_) => const QuestScreen());
          }
        },
      ),
    );
  }
}
