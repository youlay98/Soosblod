import 'package:flutter/material.dart';

class EmailForm extends StatelessWidget {
  const EmailForm({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: TextFormField(
        textInputAction: TextInputAction.done,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
              child: Image.asset('assets/Icons/Email.png')),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xffECEEF1)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xffECEEF1)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: const Color(0xffECEEF1),
          label:
              const Text('Email', style: TextStyle(color: Color(0xff7A7C8B))),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => email == null ? 'Enter a valid email' : null,
      ),
    );
  }
}
