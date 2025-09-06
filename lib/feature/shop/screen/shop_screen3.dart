import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/const/nav_ids.dart';
import '../../widgets/profile_app_bar.dart';

class ShopScreen3 extends StatefulWidget {
  final String url; // Pass the URL to open
  const ShopScreen3({super.key, required this.url});

  @override
  State<ShopScreen3> createState() => _ShopScreen3State();
}

class _ShopScreen3State extends State<ShopScreen3> {
  String selectedGateway = 'paypal';
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Allow JS if needed
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
        onBackPressed: () => Get.back(id: NavIds.shop),
        title: 'Payment Method',
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
