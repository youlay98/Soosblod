import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreatProfileButton extends StatelessWidget {
  CreatProfileButton({
    required this.onpressed,
    super.key,
  });
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    final widthsize = MediaQuery.of(context).size.width;
    final hieghtsize = MediaQuery.of(context).size.height;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(
              width: 1,
              color: Color(0xff0099A1),
            ),
            backgroundColor: const Color(0xffFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            fixedSize: Size(widthsize * 0.6, hieghtsize * 0.06),
            foregroundColor: Theme.of(context).colorScheme.background),
        onPressed: onpressed,
        child: const Text(
          'Create Profile',
          style: TextStyle(color: Color(0xff0099A1), fontSize: 16),
        ));
  }
}
