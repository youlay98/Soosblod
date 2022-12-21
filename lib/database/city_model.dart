// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CityModel {
  String ville;
  String id;

  CityModel({
    required this.ville,
    required this.id,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        ville: json["ville"],
      );
}

List<CityModel>? userModelFromJson(String str) {
  try {
    return List<CityModel>.from(
        json.decode(str).map((x) => CityModel.fromJson(x)));
  } catch (e) {}
  return null;
}
