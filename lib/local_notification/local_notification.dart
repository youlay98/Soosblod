import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  LocalNotification();
  static String serverKey =
      'AAAAG_mAZI8:APA91bFIhnwq65I9vflMx1kq_74gRin6ORXbfrMDH9zcT6B_7SJ5YVTyoJ0smqD-AOaeSi4TsxxPCmkE9IwQqKPQb9QaVz02PwzE5VF7p4hstF4UHS7d7bHA8lQ1H_y0cQqzcLtNdKxu';

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static void intialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(1000);
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails('mychanel', 'my chanel',
              importance: Importance.high, priority: Priority.high));

      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails);
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }

  static Future<void> sendNotification(
      {String? title, String? message, String? token}) async {
    print('jlkafoeijfoaijweoifajffffffffoisjf');
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': message
    };
    try {
      http.Response r = await http.post(
          Uri.parse('http://fcm.googleapis.com/fcm/send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey'
          },
          body: jsonEncode(<String, dynamic>{
            'notification': <String, dynamic>{'body': message, 'title': title},
            'priority': 'high',
            'data': data,
            'to': '$token'
          }));
    } catch (e) {
      print('exception $e');
    }
  }

  static getdocumentIdbyuserID(userid) async {
    String? id;
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .where("UserId", isEqualTo: userid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          id = doc.id;
        }
      });
      return id;
    } catch (e) {
      Future.error(e);
    }
    return null;
  }

  static storeToken() async {
    try {
      // String? docId =
      //     await getdocumentIdbyuserID(FirebaseAuth.instance.currentUser!.uid);
      String? token = await FirebaseMessaging.instance.getToken();
      FirebaseFirestore.instance
          .collection('User')
          .doc(await getdocumentIdbyuserID(
              FirebaseAuth.instance.currentUser!.uid))
          .set({'fcmToken': token!}, SetOptions(merge: true));
    } catch (e) {
      print('error is $e');
    }
  }
}
