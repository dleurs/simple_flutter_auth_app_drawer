import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

class User {
  String uid;
  bool isAnonymous;
  String pseudo;
  String email;

  User({
    @required this.uid,
    @required this.isAnonymous,
    this.pseudo,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) => new User(
        uid: json["uid"],
        isAnonymous: json["isAnonymous"],
        pseudo: json["pseudo"] ?? null,
        email: json["email"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "isAnonymous": isAnonymous,
        "pseudo": pseudo ?? null,
        "email": email ?? null,
      };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
