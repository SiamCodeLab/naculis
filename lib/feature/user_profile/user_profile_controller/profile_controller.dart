import 'dart:convert';
import 'dart:io';  // For File handling

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';  // Import the image picker
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';
import '../model/profile_info_model.dart';

class UserController extends GetxController {
  // Text editing controllers for form fields
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController profilePictureController = TextEditingController();


  String selectedGender = 'M'; //
  String selectedCountry = 'Uk'; // Store the selected country

  Rx<File?> profileImage = Rx<File?>(null); // Store the selected profile image

  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path); // Use .value to update the Rx variable
    }
  }

  // Function to pick an image using the camera
  Future<void> pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage.value = File(pickedFile.path); // Use .value to update the Rx variable
    }
  }

  // Reactive user model
  var user = User(
    username: '',
    referralCode: '',
    referralLink: '',
    referredBy: null,
    referralCount: 0,
    email: '',
    firstName: null,
    lastName: null,
    phone: null,
    dob: null,
    gender: 'N',
    country: '',
    profilePicture: null,
    xp: 0,
    dailyStreak: 0,
    level: 0,
    hearts: 0,
    gem: 0,
    discounts: [],
  ).obs;

  // Loading state
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Load user data when the controller is initialized
  }

  // Fetch user data from API
  Future<void> fetchUserData() async {
    isLoading(true); // Start loading

    String? accessToken = await UserInfo.getAccessToken();

    try {
      final response = await http.get(
        Uri.parse(ApiEndpoints.userProfileInfo),
        headers: {
          'Authorization': 'Bearer $accessToken',
          // Add access token in the header
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        user.value = User.fromJson(jsonDecode(response.body));
        print(response.body);

        // Populate the form fields with the fetched data
        firstNameController.text = user.value.firstName ?? '';
        lastNameController.text = user.value.lastName ?? '';
        phoneController.text = user.value.phone ?? '';
        dobController.text = user.value.dob ?? '';
        profilePictureController.text = user.value.profilePicture ?? '';
      } else {
        // Handle the error if needed
        Get.snackbar(
          'Error',
          'Failed to load user data. Status Code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle any error that might occur during the request
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false); // End loading
    }
  }

  // Update user profile
  Future<void> updateUserProfile() async {
    isLoading(true);
    try {

      String? accessToken = await UserInfo.getAccessToken();

      // Validate/normalize before send
      final gender  = (selectedGender.isNotEmpty) ? selectedGender : 'N';
      final country = (selectedCountry.isNotEmpty) ? selectedCountry : 'BD';

      final Map<String, String> body = {
        'first_name': firstNameController.text.trim(),
        'last_name' : lastNameController.text.trim(),
        'phone'     : phoneController.text.trim(),
        'dob'       : dobController.text.trim(), // ensure format matches API (e.g., YYYY-MM-DD)
        'gender'    : gender,   // e.g., "M" | "F" | "N"
        'country'   : country,  // match server codes/casing
      };

      if (profileImage.value != null) {
        final req = http.MultipartRequest(
          'PUT',
          Uri.parse(ApiEndpoints.userProfileInfoUpdate),
        );
        req.headers['Authorization'] = 'Bearer $accessToken';

        // Add image
        req.files.add(await http.MultipartFile.fromPath(
          'profile_picture',
          profileImage.value!.path,
        ));

        req.fields.addAll(body);

        final streamed = await req.send().timeout(const Duration(seconds: 20));
        final responseBody = await streamed.stream.bytesToString();

        if (streamed.statusCode == 200 || streamed.statusCode == 201) {
          Get.snackbar('Success', 'Profile updated successfully');
          await fetchUserData();
        } else {
          Get.snackbar('Error',
              'Update failed (${streamed.statusCode}): $responseBody');
        }
      } else {
        final resp = await http.put(
          Uri.parse(ApiEndpoints.userProfileInfoUpdate),
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode(body),
        ).timeout(const Duration(seconds: 15));

        if (resp.statusCode == 200 || resp.statusCode == 201) {
          Get.snackbar('Success', 'Profile updated successfully');
          await fetchUserData();
        } else {
          Get.snackbar('Error',
              'Update failed (${resp.statusCode}): ${resp.body}');
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    } finally {
      isLoading(false);
    }
  }



  // Dispose controllers to prevent memory leaks
  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    profilePictureController.dispose();
    super.dispose();
  }
}
