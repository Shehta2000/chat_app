import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Face extends StatelessWidget {
  const Face({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => signInWithFacebook(),
          child: Image.asset(
            'lib/assets/images/facebook-logo-13.png',
            height: 50,
            width: 50,
          ),
        )
      ],
    );
  }
}

Future<UserCredential?> signInWithFacebook() async {
  try {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  } catch (e) {
    print('Error signing in with Facebook: $e');
  }

  return null;
}
