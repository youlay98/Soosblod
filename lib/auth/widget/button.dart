import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({super.key, required this.name, required this.onpressed});
  String name;
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    final hieghtsize = MediaQuery.of(context).size.height;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffED252F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fixedSize: Size(widthsize * 0.6, hieghtsize * 0.06),
            foregroundColor: Theme.of(context).colorScheme.background),
        onPressed: onpressed,
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ));
  }
}
