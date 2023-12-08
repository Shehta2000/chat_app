import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.hintText,
      this.onChanged,
      this.Icon,
      this.obscureText = false});
  String? hintText;
  Function(String)? onChanged;
  IconButton? Icon;
  bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is Required';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: newColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: newColor),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: newColor),
        ),
      ),
    );
  }
}
