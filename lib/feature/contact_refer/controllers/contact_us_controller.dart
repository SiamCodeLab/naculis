

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/const/api_endpoints.dart';
import '../../../core/local_storage/user_info.dart';


class ContactUsController extends GetxController{


  final titleController = TextEditingController();
  final messageController = TextEditingController();


  Future<void> sendContactUs() async {

    final url=Uri.parse(ApiEndpoints.contactUs);
    try{

      String? accessToken = await UserInfo.getAccessToken();
      final response= await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      body: jsonEncode({
        'title': titleController.text,
        'message': messageController.text,
      }),

      );
      if(response.statusCode==201){
        final data=jsonDecode(response.body);
        Get.snackbar('Success', 'Message sent successfully: ${data['message']}',

        );
        titleController.clear();
        messageController.clear();}

    } catch(e){
      Get.snackbar('Error', 'Failed to send message: $e',

      );
    }

  }
}