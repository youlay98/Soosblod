import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosblood/hompage/widget/blood_drop_down.dart';
import 'package:sosblood/hompage/widget/blood_item.dart';
import 'package:sosblood/hompage/widget/drop_down_button.dart';

import '../../database/database.dart';
import '../../user/user.dart';
import 'downloadwedgit.dart';

final alldonnerfuture = FutureProvider.autoDispose(
  (ref) {
    final donnerdata = ref.watch(databaseProvider);

    if (ref.read(cityprovider.notifier).state!.isEmpty &&
        ref.read(bloodprovider.notifier).state!.isEmpty) {
      return donnerdata.getALLDonerData();
    } else {
      return donnerdata.getDonorBySearsh(ref.read(cityprovider.notifier).state!,
          ref.read(bloodprovider.notifier).state!);
    }
  },
);

class B extends ConsumerWidget {
  const B({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alldonnerfutur = ref.watch(alldonnerfuture);

    return alldonnerfutur.when(
        data: (value) => Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width / 1.09,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: value.docs.length,
                      itemBuilder: (context, index) {
                        AUser aUser = AUser.fromFirestore(value.docs[index]);
                        return BloodItemDonner(user: aUser);
                      })),
            ),
        error: (e, Stack) => Text('data $e'),
        loading: () => Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.09,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const Skaltone();
                    }),
              ),
            ));
  }
}
