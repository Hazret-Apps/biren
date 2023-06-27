// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;
  final String mail;
  final String password;
  final String? studentPhoneNumber;
  final String? parentPhoneNumber;
  final bool isVerified;
  final grade;
  final classText;
  final Timestamp createdTime;
  final String uid;

  const UserModel({
    this.grade,
    this.classText,
    this.studentPhoneNumber,
    this.parentPhoneNumber,
    required this.name,
    required this.mail,
    required this.password,
    required this.createdTime,
    required this.isVerified,
    required this.uid,
  });
}
