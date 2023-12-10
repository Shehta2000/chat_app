import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubleForFriend extends StatelessWidget {
  const ChatBubleForFriend({
    required this.message,
    super.key,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 22, bottom: 22, right: 16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 19, 69, 93),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32),
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              // Display the time in HH:mm format
              DateFormat('HH:mm').format(message.createdAt.toDate()),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
