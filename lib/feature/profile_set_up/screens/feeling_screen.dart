import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_string.dart';
import '../../../core/const/demo_data.dart';
import '../../home/controller/home_controller.dart';
import '../slang_controller/often_slang_controller.dart';
import '../widget/selected_btn.dart';
import '../widget/un_selected_btn.dart';

class FeelingScreen extends StatelessWidget {
  const FeelingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SlangController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset('assets/images/setup_progress/3.png'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Image.asset('assets/images/one_eye_cat.png', width: 50),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(AppStringEn.howAreYouFeeling.tr,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppStringEn.chooseSlangTypes.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: controller.slangList.length,
                itemBuilder: (context, index) {
                  final vibe = controller.slangList[index];
                  final vibeData = DemoData.setupData['feeling']![index];
                  final RxBool isSelected = controller.selectedSlangList
                      .contains(index)
                      .obs;

                  return Obx(
                    () => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: isSelected.value
                          ? SelectedBtn(
                              icon: vibeData['icon'],
                              title: vibe.name,
                              onTap: () {
                                isSelected.value = false;
                                controller.selectedSlangList.remove(index);
                                controller.feelsList.remove(vibe.slangId);
                                print(controller.feelsList);
                              },
                            )
                          : UnSelectedBtn(
                              icon: vibeData['icon'],
                              title: vibe.name,
                              onTap: () {
                                isSelected.value = true;
                                controller.selectedSlangList.add(index);
                                controller.feelsList.add(vibe.slangId);
                                print(controller.feelsList);
                              },
                            ),
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
               controller.postMoodData();
               Get.put(LevelsController());

              },
              child: Text(
                AppStringEn.next.tr,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
