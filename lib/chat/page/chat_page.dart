import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sosblood/chat/database/chat_provider.dart';
import 'package:sosblood/hompage/hom_page.dart';
import 'package:sosblood/hompage/widget/blood_item.dart';
import 'package:sosblood/local_notification/local_notification.dart';
import '../../user/user.dart';
import '../chat_model/chat_model.dart';
import '../widget/textfield_for_chat.dart';

final stramprovider = StreamProvider.autoDispose((ref) {
  Stream<QuerySnapshot> stream = FirebaseFirestore.instance
      .collection('message')
      .doc(ref.read(messagID.notifier).state)
      .collection('messages')
      .snapshots();
  return stream.map((qShot) => qShot.docs
      .map((doc) => ChatMessages(
          idFrom: doc['idFrom'],
          idTo: doc['idTo'],
          timestamp: doc['timestamp'].toDate(),
          content: doc['content']))
      .toList());

  // if (ref.read(romIdType.notifier).state == 2) {
  //   Stream<QuerySnapshot> stream = FirebaseFirestore.instance
  //       .collection('message')
  //       .doc(
  //           '${ref.read(uid2.notifier).state}${FirebaseAuth.instance.currentUser!.uid}')
  //       .collection('messages')
  //       .snapshots();
  //   return stream.map((qShot) => qShot.docs
  //       .map((doc) => ChatMessages(
  //           idFrom: doc['idFrom'],
  //           idTo: doc['idTo'],
  //           timestamp: doc['timestamp'].toDate(),
  //           content: doc['content']))
  //       .toList());
  // } else {
  //   Stream<QuerySnapshot> stream = FirebaseFirestore.instance
  //       .collection('message')
  //       .doc(
  //           '${FirebaseAuth.instance.currentUser!.uid}${ref.read(uid2.notifier).state}')
  //       .collection('messages')
  //       .snapshots();
  //   return stream.map((qShot) => qShot.docs
  //       .map((doc) => ChatMessages(
  //           idFrom: doc['idFrom'],
  //           idTo: doc['idTo'],
  //           timestamp: doc['timestamp'].toDate(),
  //           content: doc['content']))
  //       .toList());
  // }
});

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key, required this.user2});
  final AUser user2;

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final message = TextEditingController();
  final List<ChatMessages> _messages = [];
  late ChatProvider database;

  @override
  void initState() {
    super.initState();
    database = ref.read(chatdatabaseProvider);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.user2.fcmToken);
    final streamdata = ref.watch(stramprovider);
    double heightsize = MediaQuery.of(context).size.height;
    double widthsize = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomePage()),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xff979797).withOpacity(0.3),
                  radius: 50,
                  child: Image.asset('assets/profile.png'),
                  //Text
                ),
                Text(
                  widget.user2.fullname!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
            Expanded(
                child: streamdata.when(
                    data: (value) {
                      return GroupedListView(
                        order: GroupedListOrder.ASC,
                        groupBy: (message) => DateTime(
                            message.timestamp.year,
                            message.timestamp.month,
                            message.timestamp.day,
                            message.timestamp.hour,
                            message.timestamp.minute,
                            message.timestamp.second,
                            message.timestamp.millisecond),
                        groupHeaderBuilder: (ChatMessages messag) =>
                            const SizedBox(),
                        itemBuilder: (context, ChatMessages messag) {
                          return Align(
                            alignment: (messag.idFrom ==
                                    FirebaseAuth.instance.currentUser!.uid)
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child:
                                // SizedBox(
                                //     width: messag.idFrom ==
                                //             FirebaseAuth
                                //                 .instance.currentUser!.uid
                                //         ? 20
                                //         : 0),
                                // Column(
                                //   children: [
                                //     CircleAvatar(
                                //       backgroundColor: const Color(0xff979797)
                                //           .withOpacity(0.3),
                                //       radius: 15,
                                //       //Text
                                //     ),
                                //     const SizedBox(
                                //       height: 40,
                                //     )
                                //   ],
                                // ),
                                Card(
                              color: messag.idFrom ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? const Color(0xff0099A1)
                                  : const Color(0xffF7F7F7),
                              elevation: 8,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  messag.content,
                                  style: TextStyle(
                                    color: messag.idFrom ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        elements: value,
                      );
                    },
                    error: (e, Stack) => Text('error is: $e , \n $Stack'),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()))),
            Row(
              children: [
                SizedBox(
                  width: widthsize / 1.2,
                  height: 70,
                  child: Center(
                    child: TextFieldChat(
                      controller: message,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (message.text.isNotEmpty) {
                      ChatMessages m = ChatMessages(
                          content: message.text,
                          idFrom: FirebaseAuth.instance.currentUser!.uid,
                          idTo: widget.user2.userId!,
                          timestamp: DateTime.now());
                      LocalNotification.sendNotification(
                          title: 'New Message',
                          message: message.text,
                          token: widget.user2.fcmToken);
                      message.clear();
                      await database.sendMessage(
                          ref.read(messagID.notifier).state, m);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: const Color(0xff0099A1)),
                    height: widthsize / 7,
                    width: widthsize / 7,
                    child: Image.asset(
                      'assets/Send.png',
                      color: Colors.white,
                    ),
                  ),
                ),
                // const Spacer(
                //   flex: 2,
                // ),

                // const Spacer(
                //   flex: 2,
                // ),

                // const Spacer(
                //   flex: 2,
                // ),
              ],
            ),

            // Expanded(
            //     child: Container(
            //   color: Colors.amber,
            // )),

            // SizedBox(
            //   height: heightsize / 2,
            //   width: double.infinity,
            //   child: Row(
            //     children: [

            //       ElevatedButton(
            //         onPressed: () {},
            //         child: const Icon(Icons.abc_outlined),
            //       )
            //     ],
            //   ),
            // )
            SizedBox(
              height: heightsize / 25,
            )
          ],
        ),
      ),
    );
  }
}
