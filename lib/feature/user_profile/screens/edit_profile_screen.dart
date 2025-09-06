import 'dart:io'; // For File handling
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/const/app_string.dart';
import '../../../core/const/nav_ids.dart';
import '../../widgets/profile_app_bar.dart';
import '../user_profile_controller/profile_controller.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController profileController = Get.put(UserController());

  // Dropdown selections
  final genderOptions = ['Male', 'Female', 'Other'];
  final countryOptions = [
    'United Kingdom',
    'United States of America',
    'Canada',
    'Spain',
    'United Arab Emirates',
    'China',
    'Germany',
    'Russia',
    'Ukraine',
  ];

  String selectedGender = 'N';
  String selectedCountry = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
        onBackPressed: () => Get.back(id: NavIds.profile),
        title: AppStringEn.editProfile.tr,
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = profileController.user.value;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Image & Edit Icon
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Obx(
                      () => CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            profileController.profileImage.value != null
                            ? FileImage(profileController.profileImage.value!)
                            : (user.profilePicture != null &&
                                  user.profilePicture!.isNotEmpty)
                            ? NetworkImage(user.profilePicture!)
                                  as ImageProvider
                            : const NetworkImage(
                                'https://i.pravatar.cc/150?img=3',
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // Open the image picker to choose an image from gallery or camera
                        _showImagePickerDialog();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                user.username ?? '',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                user.email,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 14),
              ),

              const SizedBox(height: 30),

              // Name Fields
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: AppStringEn.yourName.tr,
                      hint: 'First Name',
                      controller: profileController.firstNameController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      label: AppStringEn.lastName.tr ?? 'Last Name',
                      hint: 'Last Name',
                      controller: profileController.lastNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              CustomTextField(
                label: AppStringEn.emailAddress.tr,
                hint: user.email,
                isEditable: false,
                controller: TextEditingController(), // <-- use null, NOT false
              ),

              const SizedBox(height: 15),

              CustomTextField(
                label: AppStringEn.phone.tr,
                hint: 'Phone Number',
                controller: profileController.phoneController,
              ),
              const SizedBox(height: 15),

              CustomDropdown(
                label: AppStringEn.gender.tr,
                items: genderOptions,
                initialValue: _mapGenderCodeToLabel(selectedGender),
                onChanged: (String val) {
                  setState(() {
                    profileController.selectedGender = _mapGenderLabelToCode(
                      val,
                    );
                    selectedGender = _mapGenderLabelToCode(val);
                  });
                },
              ),
              const SizedBox(height: 15),

              CustomTextField(
                label: AppStringEn.Birthday.tr,
                hint: '2000-01-01',
                suffixIcon: IconButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          profileController.dobController.text.isNotEmpty
                          ? DateTime.tryParse(
                                  profileController.dobController.text,
                                ) ??
                                DateTime.now()
                          : DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      profileController.dobController.text = pickedDate
                          .toIso8601String()
                          .split('T')
                          .first;
                    }
                  },
                  icon: Icon(Icons.calendar_today, color: Colors.grey[700]),
                ),
                controller: profileController.dobController,
              ),
              const SizedBox(height: 15),
              CustomDropdown(
                label: AppStringEn.country.tr,
                items: countryOptions,
                initialValue: selectedCountry.isNotEmpty
                    ? selectedCountry
                    : countryOptions.first,
                onChanged: (String val) {
                  setState(() {
                    profileController.selectedCountry = val.toUpperCase();
                    selectedCountry = val.toUpperCase();
                  });
                },
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Automatically trigger the profile update request
                    profileController.updateUserProfile();
                  },
                  child: Text(
                    AppStringEn.save.tr,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  // Helper to convert gender code (N, M, F, O) to label string
  String _mapGenderCodeToLabel(String code) {
    switch (code.toUpperCase()) {
      case 'M':
        return 'Male';
      case 'F':
        return 'Female';
      case 'O':
        return 'Other';
      default:
        return 'Other'; // or 'N' could map to 'Other' or empty
    }
  }

  // Helper to convert label string to gender code
  String _mapGenderLabelToCode(String label) {
    switch (label.toLowerCase()) {
      case 'male':
        return 'M';
      case 'female':
        return 'F';
      case 'other':
        return 'O';
      default:
        return 'N';
    }
  }

  // Show image picker dialog to select camera or gallery
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  profileController.pickImageFromGallery();
                },
              ),
              ListTile(
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  profileController.pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
