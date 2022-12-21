import 'package:flutter/material.dart';

class CityForm extends StatelessWidget {
  const CityForm({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            value != null && value.length < 4 ? 'Enter a City' : null,
        textInputAction: TextInputAction.done,
        controller: controller,
        decoration: InputDecoration(
          // suffixIcon: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
          //     child: Image.asset('assets/Icons/Profile.png', width: 0.1)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
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
          fillColor: Colors.white,
          label: const Text('City', style: TextStyle(color: Color(0xff7A7C8B))),
        ),
      ),
    );
  }
}
