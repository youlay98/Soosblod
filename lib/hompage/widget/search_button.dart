import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchButton extends StatelessWidget {
  SearchButton({super.key, required this.onpressed});
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    final hieghtsize = MediaQuery.of(context).size.height;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff0099A1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            fixedSize: Size(
              hieghtsize / 15,
              hieghtsize / 15,
            ),
            foregroundColor: Theme.of(context).colorScheme.background),
        onPressed: onpressed,
        child: Image.asset('assets/search.png'));
  }
}
