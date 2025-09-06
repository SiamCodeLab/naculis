import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_string.dart';
import '../../../core/const/demo_data.dart';
import '../../../routes/route_name.dart';
import '../slang_controller/often_slang_controller.dart';
import '../widget/selected_btn.dart';
import '../widget/un_selected_btn.dart';

class VibeScreen extends StatelessWidget {
  VibeScreen({super.key});

  final controller = Get.find<SlangController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset('assets/images/setup_progress/2.png'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header
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
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        AppStringEn.whatsYourVibe.tr,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme
                    .of(context)
                    .brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            // Vibe list
            Expanded(
              child: ListView.builder(
                itemCount: controller.moodList.length,
                itemBuilder: (context, index) {
                  final vibe = controller.moodList[index];
                  int moodId = controller.moodList[index].moodId.toInt();
                  final vibe1 = DemoData.setupData["vibe"]![index];

                  final RxBool isSelected = controller.selectedVibeList.contains(index).obs;

                  return Obx(
                        () => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: !isSelected.value
                          ? UnSelectedBtn(
                        icon: vibe1['icon'],
                        title: vibe.name,
                        onTap: () {
                          isSelected.value = true; // mark selected
                          controller.vibeList.add(moodId);
                          controller.selectedVibeList.add(index);
                        },
                      )
                          : SelectedBtn(
                        icon: vibe1['icon'],
                        title: vibe.name,
                        onTap: () {
                          isSelected.value = false; // mark unselected
                          controller.vibeList.remove(moodId);
                          controller.selectedVibeList.remove(index);
                        },
                      ),
                    ),
                  );

                },
              ),
            ),

            // Next button
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  if(controller.vibeList.isNotEmpty){
                    Get.toNamed(RouteName.feeling);
                  }else{
                    Get.snackbar('No Item Selected', "Please select at least one item");
                  }
                },
                child: Text(
                  AppStringEn.next.tr,
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
