import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/utils.dart';
import '../../chat/database/chat_provider.dart';
import '../../chat/page/chat_page.dart';
import '../../user/user.dart';

// final cityprovider = StateProvider<String?>((ref) {
//   return '';
// });
final uid2 = StateProvider<String?>((ref) {
  return '';
});

final messagID = StateProvider<String>((ref) {
  return '';
});

class BloodItemDonner extends ConsumerStatefulWidget {
  const BloodItemDonner({super.key, required this.user});
  final AUser user;

  @override
  ConsumerState<BloodItemDonner> createState() => _BloodItemDonnerState();
}

class _BloodItemDonnerState extends ConsumerState<BloodItemDonner> {
  late ChatProvider datatbase;

  @override
  void initState() {
    datatbase = ref.read(chatdatabaseProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    double heightsize = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.11),
                offset: const Offset(0.0, 4.0), //(x,y)
                blurRadius: 12,
              ),
            ],
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        height: heightsize / 10,
        child: Row(
          children: [
            const Spacer(
              flex: 1,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xffE5F5F6),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              width: widthsize / 8,
              height: widthsize / 8,
              child: Center(
                  child: Text(
                widget.user.bloodType!,
                style: const TextStyle(
                    fontSize: 25,
                    color: Color(0XFF0099A1),
                    fontWeight: FontWeight.bold),
              )),
            ),
            const Spacer(
              flex: 1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.fullname!,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset('assets/city.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.user.city!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(
              flex: 8,
            ),
            GestureDetector(
              onTap: () async {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: ((context) => const Center(
                          child: CircularProgressIndicator(),
                        )));
                try {
                  ref.read(messagID.notifier).state = await datatbase.creatRome(
                      FirebaseAuth.instance.currentUser!.uid,
                      widget.user.userId!);
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatPage(user2: widget.user)),
                  );
                } catch (e) {
                  Utils.showSnackBar(e.toString());
                }
              },
              child: Image.asset(
                'assets/Send.png',
                scale: 0.8,
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
