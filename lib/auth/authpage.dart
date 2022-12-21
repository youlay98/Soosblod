import 'package:flutter/material.dart';
import 'package:sosblood/auth/signin.dart';

import 'sign_up.dart';

class Authpage extends StatefulWidget {
  const Authpage({super.key});

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {
  bool islogin = true;

  @override
  Widget build(BuildContext context) {
    return islogin
        ? SignIn(onClickedSignup: toggel)
        : SignUp(
            onClickedSignIn: toggel,
          );
  }

  void toggel() => setState(() => islogin = !islogin);
}
