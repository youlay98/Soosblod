import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sosblood/hompage/widget/alldatadonner1.dart';
import 'package:sosblood/hompage/widget/alldatadonner2.dart';

final searchbuttoncileckedProvidere = StateProvider((ref) => false);

// final alldonnerfuture = FutureProvider(
//   (ref) {
//     final donnerdata = ref.watch(databaseProvider);

//     return donnerdata.getALLDonerData();
//   },
// );

// final donndrfuture = FutureProvider(
//   (ref) {
//     final donnerdata = ref.watch(databaseProvider);
//     print(ref.read(cityprovider.notifier).state!.isEmpty &&
//         ref.read(bloodprovider.notifier).state!.isEmpty);
//     if (ref.read(cityprovider.notifier).state!.isEmpty &&
//         ref.read(bloodprovider.notifier).state!.isEmpty) {
//       return donnerdata.getALLDonerData();
//     } else {
//       return donnerdata.getDonorBySearsh(ref.read(cityprovider.notifier).state!,
//           ref.read(bloodprovider.notifier).state!);
//     }
//   },
// );

class Blooddoner extends ConsumerStatefulWidget {
  const Blooddoner({
    super.key,
  });

  @override
  ConsumerState<Blooddoner> createState() => _BlooddonerState();
}

class _BlooddonerState extends ConsumerState<Blooddoner> {
  // late Database database;
  // late Future<QuerySnapshot<Map<String, dynamic>>> v;
  bool isclicked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isclicked = ref.watch(searchbuttoncileckedProvidere);

    return isclicked ? const A() : const B();

    // return FutureBuilder(
    //     future: v,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return Padding(
    //           padding: const EdgeInsets.only(top: 30),
    //           child: SizedBox(
    //               height: MediaQuery.of(context).size.height / 2,
    //               width: MediaQuery.of(context).size.width / 1.09,
    //               child: ListView.builder(
    //                   scrollDirection: Axis.vertical,
    //                   itemCount: snapshot.data!.docs.length,
    //                   itemBuilder: (context, index) {
    //                     AUser aUser =
    //                         AUser.fromFirestore(snapshot.data!.docs[index]);
    //                     return BloodItemDonner(user: aUser);
    //                   })),
    //         );
    //       } else {
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     });
  }

  void toggel() => setState(() {});
}
