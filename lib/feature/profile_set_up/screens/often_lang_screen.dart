import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/const/app_string.dart';
import '../../../core/const/demo_data.dart';
import '../../../routes/route_name.dart';
import '../slang_controller/often_slang_controller.dart';
import '../widget/selected_btn.dart';
import '../widget/un_selected_btn.dart';

class OftenLangScreen extends StatefulWidget {
  const OftenLangScreen({super.key});

  @override
  State<OftenLangScreen> createState() => _OftenLangScreenState();
}

class _OftenLangScreenState extends State<OftenLangScreen> {
  final controller = Get.put(SlangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
        ),
        title: Image.asset('assets/images/setup_progress/1.png'),
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
                      child: Text(
                        AppStringEn.whatLanguageUsed.tr,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
              AppStringEn.slangPathNote.tr,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: DemoData.setupData['language']?.length ?? 0,
              itemBuilder: (context, index) {
                final vibe = DemoData.setupData['language']![index];

                return Obx(() {
                  // Check if this index is selected
                  final isSelected = controller.selectedIndex.value == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: isSelected
                        ? SelectedBtn(
                            icon: vibe['icon'],
                            title: vibe['title'],
                            onTap: () {
                              controller.selectedIndex.value = index;

                              // Update language code
                              if (vibe['title'] == 'English') {
                                controller.language.value = 'en';
                              } else if (vibe['title'] == 'Spanish (España)') {
                                controller.language.value = 'es';
                              } else {
                                controller.language.value = 'en';
                              }
                            },
                          )
                        : UnSelectedBtn(
                            icon: vibe['icon'],
                            title: vibe['title'],
                            onTap: () {
                              controller.selectedIndex.value = index;

                              // Update language code
                              if (vibe['title'] == 'English') {
                                controller.language.value = 'en';
                              } else if (vibe['title'] == 'Spanish (España)') {
                                controller.language.value = 'es';
                              } else {
                                controller.language.value = 'en';
                              }
                            },
                          ),
                  );
                });
              },
            ),

          ],
        ),

      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16.0),
        child: ElevatedButton(
          onPressed: () {
            if (controller.language.value == '') {
              Get.snackbar("Error", "Please select a language");
            } else {
              Get.toNamed(RouteName.vibe);
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            AppStringEn.start.tr,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
