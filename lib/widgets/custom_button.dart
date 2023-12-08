import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.text, this.onTap});
  String text;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: newColor, borderRadius: BorderRadius.circular(8)),
        width: double.infinity,
        height: 60,
        child: Center(
            child: Text(
          text,
          style: TextStyle(fontSize: 22, color: Colors.white),
        )),
      ),
    );
  }
}
