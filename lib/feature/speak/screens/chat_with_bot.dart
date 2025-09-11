
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/custom_appbar.dart';
import 'chat_controller.dart';

class ChatWithBotScreen extends StatelessWidget {
  ChatWithBotScreen({super.key});
  final ChatController controller = Get.put(ChatController(), permanent: true);
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

              return ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: controller.messages.length,
                itemBuilder: (_, index) {
                  final msg = controller.messages[index];
                  final isError = msg['message'].toString().toLowerCase().startsWith("error") ||
                      msg['message'].toString().toLowerCase().contains("failed");

                  if (msg['isVoice'] == true) {
                    return VoiceMessageBubble(
                      isSender: msg['isSender'],
                      path: msg['path'],
                    );
                  } else {
                    return ChatBubble(
                      message: msg['message'],
                      isSender: msg['isSender'],
                      isError: isError,
                    );
                  }
                },
              );
            }),
          ),

          /// Typing indicator (loading state)
          Obx(() {
            if (controller.isRecording.value) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "🎙️ Listening...",
                  style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
                ),
              );
            }
            return const SizedBox.shrink();
          }),

          /// Mic button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => GestureDetector(
              onLongPress: controller.startRecording,
              onLongPressUp: controller.stopRecording,
              child: CircleAvatar(
                radius: 32,
                backgroundColor: controller.isRecording.value
                    ? Colors.red
                    : Theme.of(context).colorScheme.primary,
                child: Icon(
                  controller.isRecording.value ? Icons.stop : Icons.mic,
                  size: 30,
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

// ------------------- CHAT BUBBLE -------------------
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final bool isError;

  const ChatBubble({
    required this.message,
    required this.isSender,
    this.isError = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: screenWidth * 0.7),
        decoration: BoxDecoration(
          color: isError
              ? Colors.red.shade100
              : (isSender ? Colors.blue : Colors.grey.shade300),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: isSender ? const Radius.circular(14) : const Radius.circular(0),
            bottomRight: isSender ? const Radius.circular(0) : const Radius.circular(14),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isError
                ? Colors.red.shade800
                : (isSender ? Colors.white : Colors.black87),
          ),
        ),
      ),
    );
  }
}

// ------------------- VOICE MESSAGE BUBBLE -------------------
class VoiceMessageBubble extends StatelessWidget {
  final bool isSender;
  final String? path;

  const VoiceMessageBubble({required this.isSender, this.path, super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();
    final bubbleColor = isSender ? Colors.blue : Colors.grey.shade300;
    final textColor = isSender ? Colors.white : Colors.black87;

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onTap: () async {
          if (path != null) {
            await controller.playVoice(path!);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.play_arrow, color: Colors.white),
              const SizedBox(width: 8),
              Text('Voice Message', style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
