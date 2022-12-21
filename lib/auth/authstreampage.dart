import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosblood/auth/widget/verificationdone.dart';
import 'authPage.dart';

class Loginandsigninpage extends StatelessWidget {
  const Loginandsigninpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const VerificationIsDone();
              } else {
                return const Authpage();
              }
            }),
      ),
    );
  }
}
