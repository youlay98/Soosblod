import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosblood/hompage/hom_page.dart';

import '../../selectpage.dart';

final isverfide = FutureProvider.autoDispose((ref) async {
  bool v = false;
  await FirebaseFirestore.instance
      .collection('User')
      .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((QuerySnapshot querySnapshot) async {
    for (var doc in querySnapshot.docs) {
      v = await doc['isverifide'];
    }
  });

  return v;
});

class VerificationIsDone extends ConsumerStatefulWidget {
  const VerificationIsDone({super.key});

  @override
  ConsumerState<VerificationIsDone> createState() => _VerificationIsDoneState();
}

class _VerificationIsDoneState extends ConsumerState<VerificationIsDone> {
  Stream<bool>? isverficationdone;

  @override
  Widget build(BuildContext context) {
    AsyncValue<bool>? isverifider = ref.watch(isverfide);

    return isverifider!.when(
        data: (value) => value ? const HomePage() : const SelectPage(),
        error: (e, Stack) => Text('data $e'),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
