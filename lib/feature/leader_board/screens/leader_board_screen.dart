import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/image_icon.dart';
import '../../widgets/custom_appbar.dart';
import '../controller/leaderboard_controller.dart';
import '../widgets/leader_board_card.dart';
import '../widgets/leaderboard_header.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  int _selectedIndex = 0; // ✅ Default select Gems

  // Instantiate the controller
  final LeaderboardController leaderboardController = Get.put(
    LeaderboardController(),
    permanent: true,
  );

  @override
  void initState() {
    super.initState();
    leaderboardController.fetchGems(); // ✅ Load Gems data initially
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          // Leaderboard header
          LeaderboardHeader(),

          // Horizontal Row with 4 selectable buttons
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildButton(0, 'Gems', ImageAndIconConst.appbarIcon4),
                buildButton(1, 'XP', ImageAndIconConst.appbarIcon3),
                buildButton(2, 'Daily', ImageAndIconConst.appbarIcon2),
                buildButton(3, 'Perfect', ImageAndIconConst.trophy),
              ],
            ),
          ),

          // Show loading indicator while fetching data
          Obx(() {
            if (leaderboardController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (leaderboardController.errorMessage.value.isNotEmpty) {
              return Center(
                child: Text(leaderboardController.errorMessage.value),
              );
            }

            // Expanded section to show ListView based on the selected button
            return Expanded(
              child: ListView.builder(
                itemCount: leaderboardController.leaderboard.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  var user = leaderboardController.leaderboard[index];
                  return Card(
                    elevation: 2,
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(user['username'] ?? 'Unknown'),
                      subtitle: Text(
                        _selectedIndex == 0
                            ? 'Total Gems: ${user['total_gems']}'
                            : _selectedIndex == 1
                            ? 'Total XP: ${user['total_xp']}'
                            : _selectedIndex == 2
                            ? 'Total Daily Streak: ${user['total_daily_streak']}'
                            : 'Perfect Lessons: ${user['total_perfect_lessons']}',
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  // Method to build each selectable button
  Widget buildButton(int index, String text, String imageAsset) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });

        // Fetch data based on the selected button
        if (index == 0) {
          leaderboardController.fetchGems();
        } else if (index == 1) {
          leaderboardController.fetchXP();
        } else if (index == 2) {
          leaderboardController.fetchDailyStreak();
        } else if (index == 3) {
          leaderboardController.fetchPerfectLessons();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Label
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: isSelected ? Colors.blue : Theme.of(context).primaryColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),

          // Box with icon
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.blue.withOpacity(0.2)
                  : Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? Colors.blue : Colors.grey,
                style: BorderStyle.solid,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
          ),
        ],
      ),
    );
  }
}
