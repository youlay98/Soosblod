// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AUser {
  String? userId;
  String? fullname;
  String? phonnumber;
  String? userType; //is he a blood donor or a blood nedeed
  int? age;
  String? city;
  String? sexe;
  String? bloodType;
  String? q1;
  String? q2;
  String? q3;
  bool? isverifide;
  String? fcmToken = '';
  AUser({
    this.fcmToken,
    this.userId,
    this.fullname,
    this.phonnumber,
    this.userType,
    this.age,
    this.city,
    this.sexe,
    this.bloodType,
    this.q1,
    this.q2,
    this.q3,
    required this.isverifide,
  });

  factory AUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return AUser(
        fcmToken: data?['fcmToken'],
        userId: data?['UserId'],
        fullname: data?['name'],
        bloodType: data?['bloodType'],
        city: data?['City'],
        isverifide: data?['isverifide']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'fullname': fullname,
      'phonnumber': phonnumber,
      'userType': userType,
      'age': age,
      'city': city,
      'sexe': sexe,
      'bloodType': bloodType,
      'q1': q1,
      'q2': q2,
      'q3': q3,
      'isverifide': isverifide,
    };
  }

  factory AUser.fromMap(Map<String, dynamic> map) {
    return AUser(
      userId: map['userId'] != null ? map['userId'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      phonnumber:
          map['phonnumber'] != null ? map['phonnumber'] as String : null,
      userType: map['userType'] != null ? map['userType'] as String : null,
      age: map['age'] != null ? map['age'] as int : null,
      city: map['city'] != null ? map['city'] as String : null,
      sexe: map['sexe'] != null ? map['sexe'] as String : null,
      bloodType: map['bloodType'] != null ? map['bloodType'] as String : null,
      q1: map['q1'] != null ? map['q1'] as String : null,
      q2: map['q2'] != null ? map['q2'] as String : null,
      q3: map['q3'] != null ? map['q3'] as String : null,
      isverifide: map['isverifide'] != null ? map['isverifide'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AUser.fromJson(String source) =>
      AUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AUser(userId: $userId, fullname: $fullname, phonnumber: $phonnumber, userType: $userType, age: $age, city: $city, sexe: $sexe, bloodType: $bloodType, q1: $q1, q2: $q2, q3: $q3, isverifide: $isverifide)';
  }

  @override
  bool operator ==(covariant AUser other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.fullname == fullname &&
        other.phonnumber == phonnumber &&
        other.userType == userType &&
        other.age == age &&
        other.city == city &&
        other.sexe == sexe &&
        other.bloodType == bloodType &&
        other.q1 == q1 &&
        other.q2 == q2 &&
        other.q3 == q3 &&
        other.isverifide == isverifide;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        fullname.hashCode ^
        phonnumber.hashCode ^
        userType.hashCode ^
        age.hashCode ^
        city.hashCode ^
        sexe.hashCode ^
        bloodType.hashCode ^
        q1.hashCode ^
        q2.hashCode ^
        q3.hashCode ^
        isverifide.hashCode;
  }

  AUser copyWith({
    String? userId,
    String? fullname,
    String? phonnumber,
    String? userType,
    int? age,
    String? city,
    String? sexe,
    String? bloodType,
    String? q1,
    String? q2,
    String? q3,
    bool? isverifide,
  }) {
    return AUser(
      userId: userId ?? this.userId,
      fullname: fullname ?? this.fullname,
      phonnumber: phonnumber ?? this.phonnumber,
      userType: userType ?? this.userType,
      age: age ?? this.age,
      city: city ?? this.city,
      sexe: sexe ?? this.sexe,
      bloodType: bloodType ?? this.bloodType,
      q1: q1 ?? this.q1,
      q2: q2 ?? this.q2,
      q3: q3 ?? this.q3,
      isverifide: isverifide ?? this.isverifide,
    );
  }
}
