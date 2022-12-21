import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final cityprovider = StateProvider<String>((ref) => '');
final cityprovider = StateProvider<String?>((ref) {
  return '';
});

class CityDopdown extends ConsumerStatefulWidget {
  const CityDopdown({
    super.key,
  });

  @override
  ConsumerState<CityDopdown> createState() => _CityDopdownState();
}

class _CityDopdownState extends ConsumerState<CityDopdown> {
  @override
  void initState() {
    super.initState();
  }

  String? selectedValue;

  final List<String> items = [
    'Casablanca',
    'Rabat',
    'Fes',
    'Salé',
    'Marrakesh',
    'Agadir',
    'Tangier',
    'Meknes',
    'Oujda',
    'Al Hoceima',
    'Kenitra',
    'Tétouan'
  ];

  @override
  Widget build(BuildContext context) {
    // final selectedValue = ref.watch(cityprovider);
    double widthsize = MediaQuery.of(context).size.width;
    double heightsize = MediaQuery.of(context).size.height;
    return Center(
        child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            Image.asset('assets/city.png'),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              child: Text(
                'City',
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
          ref.read(cityprovider.notifier).state = value as String;

          setState(() {
            selectedValue = ref.read(cityprovider.notifier).state;
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
    ));
  }
}






















































































// class Dropdownbuttonino extends StatefulWidget {
//   const Dropdownbuttonino({super.key});

//   @override
//   State<Dropdownbuttonino> createState() => _DropdownbuttoninoState();
// }

// class _DropdownbuttoninoState extends State<Dropdownbuttonino> {
//   List<CityModel> items = [];
//   final ApiService _apiService = ApiService();
//   List<String> selectedItems = [];
//   String vradio = 'Agadir';
//   String groupradio = 'Agadir';
//   @override
//   void initState() {
//     super.initState();
//     getcity();
//   }

//   void getcity() async {
//     items = await _apiService.getcity()!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double widthsize = MediaQuery.of(context).size.width;
//     double heightsize = MediaQuery.of(context).size.height;
//     return Container(
//       decoration: const BoxDecoration(
//           color: Color(0xffECEEF1),
//           borderRadius: BorderRadius.all(Radius.circular(12))),
//       width: widthsize / 2,
//       child: Center(
//         child: DropdownButtonHideUnderline(
//           child: DropdownButtonFormField2(
//             icon: Image.asset('assets/arrow_down.png'),
//             // decoration: InputDecoration(
//             //     enabledBorder: OutlineInputBorder(
//             //         borderRadius: BorderRadius.circular(20))),
//             isExpanded: true,
//             hint: Align(
//               alignment: AlignmentDirectional.center,
//               child: Row(
//                 children: [
//                   const Spacer(
//                     flex: 1,
//                   ),
//                   Image.asset(
//                     'assets/city.png',
//                     scale: 0.2,
//                   ),
//                   const Spacer(
//                     flex: 1,
//                   ),
//                   const Text(
//                     'City',
//                     style: TextStyle(
//                       fontSize: 17,
//                       color: Colors.black,
//                     ),
//                   ),
//                   const Spacer(
//                     flex: 6,
//                   ),
//                 ],
//               ),
//             ),
//             items: items.isEmpty
//                 ? null
//                 : items.map((item) {
//                     return DropdownMenuItem<CityModel>(
//                       value: item,
//                       //disable default onTap to avoid closing menu when selecting an item
//                       enabled: false,
//                       child: StatefulBuilder(
//                         builder: (context, menuSetState) {
//                           return InkWell(
//                             onTap: () {
//                               //This rebuilds the StatefulWidget to update the button's text
//                               setState(() {
//                                 print(item.ville);
//                                 groupradio = item.ville;
//                               });
//                               //This rebuilds the dropdownMenu Widget to update the check mark
//                               menuSetState(() {});
//                             },
//                             child: Container(
//                               height: double.infinity,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16.0),
//                               child: Row(
//                                 children: [
//                                   Radio<String>(
//                                     activeColor: const Color(0xffDE2D2C),
//                                     value: vradio,
//                                     groupValue: groupradio,
//                                     onChanged: (String? value) {
//                                       setState(() {
//                                         groupradio = value!;
//                                       });
//                                     },
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Text(
//                                     item.ville,
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   }).toList(),
//             //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
//             value: selectedItems.isEmpty ? null : selectedItems.last,
//             onChanged: (value) {},
//             buttonHeight: heightsize / 30,
//             itemHeight: 50,
//             itemPadding: EdgeInsets.zero,
//             selectedItemBuilder: (context) {
//               return items.map(
//                 (item) {
//                   return Container(
//                     alignment: AlignmentDirectional.center,
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       selectedItems.join(', '),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       maxLines: 1,
//                     ),
//                   );
//                 },
//               ).toList();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
