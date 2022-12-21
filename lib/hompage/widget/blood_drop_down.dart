import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bloodprovider = StateProvider<String?>((ref) {
  return '';
});

class BloodDopdown extends ConsumerStatefulWidget {
  const BloodDopdown({
    super.key,
  });

  @override
  ConsumerState<BloodDopdown> createState() => _BloodDopdownState();
}

class _BloodDopdownState extends ConsumerState<BloodDopdown> {
  final List<String> items = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    double heightsize = MediaQuery.of(context).size.height;
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: [
              Image.asset('assets/bloodx.png'),
              const SizedBox(
                width: 10,
              ),
              const Expanded(
                child: Text(
                  'Blood',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            ref.read(bloodprovider.notifier).state = value as String;

            setState(() {
              selectedValue = ref.read(bloodprovider.notifier).state;
            });
          },
          icon: Image.asset('assets/arrow_down.png'),
          iconSize: 50,
          iconEnabledColor: Colors.grey,
          iconDisabledColor: Colors.grey,
          buttonHeight: heightsize / 15,
          buttonWidth: widthsize / 3,
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            // border: Border.all(
            //   color: Colors.black26,
            // ),
            color: const Color(0xffECEEF1),
          ),
          // buttonElevation: 2,
          itemHeight: 40,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownWidth: 200,
          dropdownPadding: null,
          dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14), color: Colors.white),
          dropdownElevation: 8,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 6,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    );
  }
}
