import 'package:flutter/material.dart';

class Passwordform extends StatefulWidget {
  const Passwordform({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  // bool obscured = false;

  @override
  State<Passwordform> createState() => _PasswordformState();
}

class _PasswordformState extends State<Passwordform> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return;
      } // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: TextFormField(
        obscureText: _obscured,
        focusNode: textFieldFocusNode,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                !_obscured
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                size: 24,
                color: const Color(0xff7A7C8B),
              ),
            ),
          ),

          // /////////////////////////////////////
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13.0, horizontal: 30.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xffECEEF1)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xffECEEF1)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xffECEEF1)),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: const Color(0xffECEEF1),
          label: const Text(
            'Password',
            style: TextStyle(color: Color(0xff7A7C8B), fontSize: 16),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return;
          }
          return null;
        },
      ),
    );
  }
}
