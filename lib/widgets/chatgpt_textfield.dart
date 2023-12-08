import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyTextField2());
}

class MyTextField2 extends StatefulWidget {
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField2> {
  TextEditingController _controller = TextEditingController();
  Color _textColor = Colors.white; // Initial text color

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: TextStyle(
        color: _textColor, // Set the color of the text here
      ),
      onChanged: (text) {
        setState(() {
          // Change the text color dynamically based on some condition
          _textColor = text.contains('flutter') ? Colors.red : Colors.red;
        });
      },
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, LoginPage.id);
          },
          child: Icon(
            Icons.send,
            color: kPrimarySwatch,
          ),
        ),
        labelText: 'password',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
