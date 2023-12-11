import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snak_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  static String id = 'login page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimarySwatch,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    kLogo,
                    height: 300,
                    width: 400,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: newColor,
                          ),
                        ),
                      ],
                    ),
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
                    height: 15,
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
                    height: 20,
                  ),
                  CustomButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        try {
                          await loginUser();
                          Navigator.pushNamed(context, ChatPage.id,
                              arguments: email);
                        } on FirebaseAuthException catch (ex) {
                          if (ex.code == 'user-not-found') {
                            showSnakBar(context, ' user-not-found');
                          } else if (ex.code == 'wrong-password') {
                            showSnakBar(context, 'wrong-password');
                          }
                        } catch (ex) {
                          print(ex);
                          showSnakBar(context, 'there was an error');
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                    text: 'Sign in ',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account ? ',
                        style: TextStyle(color: newColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          '  Register',
                          style: TextStyle(
                            color: Color.fromARGB(255, 112, 113, 113),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              if (isLoading)
                Center(
                  child: SpinKitCircle(
                    color: newColor,
                    size: 50.0,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
    // You can perform additional login-related actions if needed
  }
}
