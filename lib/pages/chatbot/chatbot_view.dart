import 'package:dive_hug/pages/chatbot/chatbot_controller.dart';
import 'package:dive_hug/pages/chatbot/widgets/message_bubble.dart';
import 'package:dive_hug/pages/chatbot/widgets/message_textfiled.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotView extends GetView<ChatbotController> {
  const ChatbotView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: Padding(
            padding: EdgeInsetsGeometry.only(left: 14.w),
            child: Image.asset(
              'assets/icons/bell.png',
              width: 22.sp,
              height: 22.sp,
            ),
          ),
          title: Text(
            '안심전세 챗봇',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white
            ),
          ),
          actions: [
            Image.asset(
              'assets/icons/document.png',
              width: 22.sp,
              height: 22.sp,
            ),
            SizedBox(width: 8.w,),
            Image.asset(
              'assets/icons/notice.png',
              width: 22.sp,
              height: 22.sp,
            ),
            SizedBox(width: 8.w,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Image.asset(
                'assets/icons/close.png',
                width: 18.sp,
                height: 18.sp,
              ),
            ),
            SizedBox(width: 14.w,),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      return MessageBubble(msg: msg);
                    },
                  )),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: MessageTextfiled(
                controller: controller.textController,
                onSend: controller.sendMessage,
              ) 
            ),
          ],
        ),
      ),
    );
  }
}
