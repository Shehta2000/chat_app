import 'package:flutter/material.dart';

class AuthOptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final TextStyle? textStyle;
  final Color textColor; // Add a TextStyle parameter
  final Widget? icon; // Add a parameter for the icon (image)

  const AuthOptionButton({
    required this.text,
    required this.onPressed,
    required this.buttonColor,
    this.textStyle,
    required this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) // Only include the icon if it's provided
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6,
                ),
                child: icon,
              ),
            Text(
              text,
              style: textStyle ?? TextStyle(color: textColor, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
