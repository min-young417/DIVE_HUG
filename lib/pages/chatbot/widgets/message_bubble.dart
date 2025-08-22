import 'package:dive_hug/pages/chatbot/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key, 
    required this.msg
  });

  final Message msg;

  @override
  Widget build(BuildContext context) {
    final isUser = msg.sender == Sender.user;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blueAccent,
              child: Image.asset('assets/icons/chatbot.png', width: 18.sp, height: 18.sp,),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: isUser ? Colors.blueAccent : Colors.grey[300],
                borderRadius: isUser 
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12.sp),
                      bottomRight: Radius.circular(12.sp),
                      bottomLeft: Radius.circular(12.sp))
                  : BorderRadius.only(
                      topRight: Radius.circular(12.sp),
                      bottomLeft: Radius.circular(12.sp),
                      bottomRight: Radius.circular(12.sp))
              ),
              padding: const EdgeInsets.all(12),
              child: Text(
                msg.text,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
