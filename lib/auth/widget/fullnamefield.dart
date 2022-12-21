import 'package:flutter/material.dart';

class FullNameform extends StatelessWidget {
  const FullNameform({super.key, required this.controller});
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
              child: Image.asset('assets/Icons/Profile.png', width: 0.1)),
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
          label: const Text('Full Name',
              style: TextStyle(color: Color(0xff7A7C8B))),
        ),
      ),
    );
  }
}
