import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../chat_model/chat_model.dart';

final chatdatabaseProvider = Provider((ref) => ChatProvider());

class ChatProvider {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  ChatProvider();

  sendMessage(String messagID, ChatMessages messages) async {
    await firebaseFirestore
        .collection('message')
        .doc(messagID)
        .collection('messages')
        .add({
      'idFrom': messages.idFrom,
      'idTo': messages.idTo,
      'timestamp': messages.timestamp,
      'content': messages.content,
    });
  }

  Future<String> creatRome(String userId1, String userId2) async {
    if (await isRomeExiste(userId1, userId2) == 1 ||
        await isRomeExiste(userId1, userId2) == 2) {
      return '$userId2$userId1';
    } else {
      firebaseFirestore
          .collection('message')
          .doc('$userId1$userId2')
          .set({'messagId': '$userId1$userId2'});

      return '$userId1$userId2';
    }
  }

  Future<int> isRomeExiste(String userId1, String userId2) async {
    final doc1 = await FirebaseFirestore.instance
        .collection('message')
        .doc('$userId1$userId2')
        .get();
    final doc2 = await FirebaseFirestore.instance
        .collection('message')
        .doc('$userId2$userId1')
        .get();

    if (doc1.exists) {
      return 1;
    } else {
      if (doc2.exists) return 2;
    }

    return 0;
  }

  // Future<bool> isRomeExiste(String userId1, String userId2) async {
  //   // await firebaseFirestore
  //   //     .collection('message')
  //   //     .doc('$userId2-$userId1')
  //   //     .get()
  //   //     .then((doc) {
  //   //   print('$userId2-$userId1');
  //   //   doc1 = doc.exists;
  //   //   print(doc1);
  //   // });
  //   final docs = await firebaseFirestore
  //       .collection('message')
  //       .doc('$userId1-$userId2')
  //       .get();
  //   if (docs.exists) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // UploadTask uploadImageFile(File image, String filename) {
  //   Reference reference = firebaseStorage.ref().child(filename);
  //   UploadTask uploadTask = reference.putFile(image);
  //   return uploadTask;
  // }

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }

  Stream<QuerySnapshot> getChatMessage(String groupChatId, int limit) {
    return firebaseFirestore
        .collection('pathMessageCollection')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }

  void sendChatMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection('pathMessageCollection')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    ChatMessages chatMessages = ChatMessages(
      idFrom: currentUserId,
      idTo: peerId,
      timestamp: DateTime.now(),
      content: content,
      // type: type
    );

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toMap());
    });
  }
}

class MessageType {
  static const text = 0;
  static const image = 1;
  static const sticker = 2;
}
