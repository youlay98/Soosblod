import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessages {
  String idFrom;
  String idTo;
  DateTime timestamp;
  String content;
  // int type;

  ChatMessages({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    // required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idFrom': idFrom,
      'idTo': idTo,
      'timestamp': timestamp,
      'content': content,
      // 'type': type,
    };
  }

  factory ChatMessages.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ChatMessages(
        idFrom: data?['UserId'],
        idTo: data?['name'],
        timestamp: data?['bloodType'],
        content: data?['City']);
  }

  factory ChatMessages.fromMap(Map<String, dynamic> map) {
    return ChatMessages(
      idFrom: map['idFrom'],
      idTo: map['idTo'],
      timestamp: map['timestamp'],
      content: map['content'],
      // type: map['type'],
    );
  }
}
