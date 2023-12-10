import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'Register Page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimarySwatch,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image.asset(
                  kLogo,
                  height: 300,
                  width: 400,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            fontSize: 24,
                            color: newColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  Icon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.email,
                      color: newColor,
                    ),
                  ),
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  obscureText: true,
                  Icon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.lock,
                      color: newColor,
                    ),
                  ),
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  obscureText: true,
                  Icon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.lock,
                      color: newColor,
                    ),
                  ),
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: ' Confirm Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatPage.id);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnakBar(context, 'Weak Password');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnakBar(context, 'email already exists');
                        }
                      } catch (ex) {
                        showSnakBar(context, 'there was an error');
                      }

                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'Sign Up',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(color: newColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '  Sign in ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 112, 113, 113),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
