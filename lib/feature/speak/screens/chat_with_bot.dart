import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_appbar.dart';
import 'chat_controller.dart';

class ChatWithBotScreen extends StatelessWidget {
  ChatWithBotScreen({super.key});
  final ChatController controller = Get.put(ChatController(),permanent: true);
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemCount: controller.messages.length,
                itemBuilder: (_, index) {
                  final msg = controller.messages[index];
                  if (msg['isVoice'] == true) {
                    return VoiceMessageBubble(
                      isSender: msg['isSender'],
                      path: msg['path'],
                    );
                  } else {
                    return ChatBubble(
                      message: msg['message'],
                      isSender: msg['isSender'],
                    );
                  }
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Obx(() => GestureDetector(
              onLongPress: controller.startRecording,
              onLongPressUp: controller.stopRecording,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: controller.isRecording.value
                    ? Colors.red
                    : Theme.of(context).colorScheme.secondary,
                child: Icon(
                  controller.isRecording.value ? Icons.stop : Icons.mic,
                  color: Colors.white,
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}

// ------------------- CHAT BUBBLES -------------------
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;

  const ChatBubble({required this.message, required this.isSender, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: screenWidth - 100),
        decoration: BoxDecoration(
          color: isSender ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSender ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class VoiceMessageBubble extends StatelessWidget {
  final bool isSender;
  final String? path;

  const VoiceMessageBubble({required this.isSender, this.path, super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();
    final textColor = isSender ? Colors.white : Colors.black;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () async {
          if (path != null) {
            await controller.playVoice(path!);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSender ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.play_arrow, color: textColor),
              const SizedBox(width: 8),
              Text('Voice Message', style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
