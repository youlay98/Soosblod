import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../user/user.dart';

final databaseProvider = Provider((ref) => Database());

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String get userId => FirebaseAuth.instance.currentUser!.uid;

  getALLDonerData() async {
    try {
      return _firestore.collection('User').get();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDonorBySearsh(
      String city, String bloodtype) async {
    try {
      if (city.isEmpty && bloodtype.isNotEmpty) {
        return await _firestore
            .collection('User')
            .where('bloodType', isEqualTo: bloodtype)
            .get();
      }
      if (city.isNotEmpty && bloodtype.isEmpty) {
        return await _firestore
            .collection('User')
            .where('City', isEqualTo: city)
            .get();
      }
      if (city.isNotEmpty && bloodtype.isNotEmpty) {
        return await _firestore
            .collection('User')
            .where('City', isEqualTo: city)
            .where('bloodType', isEqualTo: bloodtype)
            .get();
      }
      return await _firestore
          .collection('User')
          .where('Citjy', isEqualTo: city)
          .get();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String> getUserName(userid) async {
    String fullname = '';
    try {
      await _firestore
          .collection('User')
          .where("UserId", isEqualTo: userid)
          .get()
          .then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          fullname = doc['name'];
        }
      });
      return fullname;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<String?> getdocumentIdbyuserID(userid) async {
    String? id;
    try {
      await _firestore
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

  Future setDataForTheBlooddDonor(AUser user) async {
    try {
      _firestore
          .collection("User")
          .doc(await getdocumentIdbyuserID(userId))
          .update({
        'age': user.age,
        'sexe': user.sexe,
        'City': user.city,
        'q1': user.q1,
        'q2': user.q2,
        'q3': user.q3,
        'bloodType': user.bloodType,
        'isverifide': user.isverifide
      });
    } catch (e) {
      return Future.error(e);
    }
  }
}
