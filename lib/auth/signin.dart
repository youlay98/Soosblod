import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sosblood/auth/utils.dart';
import 'package:sosblood/auth/widget/button.dart';
import 'package:sosblood/auth/widget/emailfield.dart';
import 'package:sosblood/auth/widget/creatProfilebutton.dart';
import 'package:sosblood/auth/widget/passwordfield.dart';

class SignIn extends StatefulWidget {
  final VoidCallback onClickedSignup;
  const SignIn({super.key, required this.onClickedSignup});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double heightsize = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: heightsize / 10),
                Image.asset('assets/Logo.png'),
                SizedBox(height: heightsize / 10),
                EmailForm(
                  controller: email,
                ),
                SizedBox(height: heightsize / 20),
                Passwordform(
                  controller: password,
                ),
                SizedBox(height: heightsize / 10),
                Button(
                  name: 'Sign In',
                  onpressed: signin,
                ),
                SizedBox(height: heightsize / 20),
                CreatProfileButton(
                  onpressed: widget.onClickedSignup,
                ),
                SizedBox(height: heightsize / 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signin() async {
    final isvalid = formkey.currentState!.validate();
    if (!isvalid) {
      print('isaghawa tcha');
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
      if (!mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Navigator.pop(context);
    }
  }
}
