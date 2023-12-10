import 'package:chat_app/constants.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ensure the user is signed out when the app starts
    signOutGoogle();

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Your background or logo image
          Image.asset(
            'lib/assets/images/welcome.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Text(
            'Welcome Back, We\'ve Missed You!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'ArchivoBlack',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                ),
                AuthOptionButton(
                  icon: Image.asset(
                    'lib/assets/images/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                    height: 30,
                    width: 30,
                  ),
                  textColor: Colors.black,
                  buttonColor: Colors.white,
                  text: 'Continue with Google',
                  onPressed: () async {
                    // Handle Google authentication
                    bool success = await signInWithGoogle(context);
                    if (success) {
                      Navigator.pushNamed(context, ChatPage.id);
                    } else {
                      print('Google Sign-In was unsuccessful.');
                    }
                  },
                ),
                AuthOptionButton(
                  textColor: Colors.white,
                  buttonColor: newColor,
                  text: 'Continue with Email',
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        print('Google Sign-In canceled by user.');
        return false;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      print('Google Sign-In successful.');
      return true;
    } catch (e) {
      print('Error signing in with Google: $e');
      return false;
    }
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    print('Google Sign-Out successful.');
  }

  // ... rest of your code
}
