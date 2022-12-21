import 'package:flutter/material.dart';

class TextFieldChat extends StatelessWidget {
  const TextFieldChat({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: TextFormField(
        textInputAction: TextInputAction.done,
        controller: controller,
        decoration: InputDecoration(
          // suffixIcon: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          //     child: Image.asset('assets/Icons/Profile.png', width: 0.1)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xffECEEF1)),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Color(0xffECEEF1)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: const Color(0xffECEEF1),
          label: const Text('Type your message',
              style: TextStyle(color: Color(0xff7A7C8B))),
        ),
      ),
    );
  }
}
