import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sosblood/auth/utils.dart';
import 'package:sosblood/auth/widget/button.dart';
import 'package:sosblood/auth/widget/fullnamefield.dart';
import 'package:sosblood/auth/widget/passwordfield.dart';
import 'package:sosblood/auth/widget/emailfield.dart';
import 'package:sosblood/auth/widget/phonmuberfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  final VoidCallback onClickedSignIn;
  const SignUp({super.key, required this.onClickedSignIn});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final email = TextEditingController();
  final phonenumber = TextEditingController();
  final fullname = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  bool valuecheckbox = false;
  @override
  Widget build(BuildContext context) {
    double heightsize = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: heightsize / 10,
                ),
                Image.asset('assets/Logo.png'),
                SizedBox(
                  height: heightsize / 20,
                ),
                FullNameform(controller: fullname),
                SizedBox(
                  height: heightsize / 20,
                ),
                Phonenumber(
                  controller: phonenumber,
                ),
                SizedBox(
                  height: heightsize / 20,
                ),
                EmailForm(
                  controller: email,
                ),
                SizedBox(
                  height: heightsize / 20,
                ),
                Passwordform(
                  controller: password,
                ),
                SizedBox(
                  height: heightsize / 50,
                ),
                Row(
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
                    Checkbox(
                      fillColor:
                          const MaterialStatePropertyAll(Color(0xff0099A1)),
                      value: valuecheckbox,
                      onChanged: (value) {
                        setState(() {
                          valuecheckbox = value!;
                        });
                      },
                    ),
                    RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff7A7C8B),
                                fontWeight: FontWeight.w500),
                            children: [
                          TextSpan(text: 'Already have an account?  '),
                          TextSpan(
                            text: 'the terms of use',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff0099A1),
                                fontWeight: FontWeight.bold),
                          )
                        ])),
                    const Spacer(
                      flex: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: heightsize / 30,
                ),
                Button(name: 'submit', onpressed: signup),
                SizedBox(
                  height: heightsize / 30,
                ),
                RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff7A7C8B),
                            fontWeight: FontWeight.w500),
                        children: [
                      const TextSpan(text: 'Already registered? '),
                      TextSpan(
                        text: ' Sign In',
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignIn,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff0099A1),
                            fontWeight: FontWeight.bold),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signup() async {
    final isvalid = formkey.currentState!.validate();

    if (!isvalid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      if (!mounted) return;
      Navigator.pop(context);

      await FirebaseFirestore.instance.collection('User').add({
        "name": fullname.text.trim(),
        "num": phonenumber.text.trim(),
        'UserId': FirebaseAuth.instance.currentUser!.uid,
        'isverifide': false
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Navigator.pop(context);
    }
  }
}
