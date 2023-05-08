import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;
  final String mail;
  final String password;
  final bool isVerified;
  final grade;
  final Timestamp createdTime;
  final String uid;

  const UserModel({
    this.grade,
    required this.name,
    required this.mail,
    required this.password,
    required this.createdTime,
    required this.isVerified,
    required this.uid,
  });
}
