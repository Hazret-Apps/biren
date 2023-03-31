import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final String name;
  final String mail;
  final String password;
  final Timestamp createdTime;

  const UserModel({
    required this.name,
    required this.mail,
    required this.password,
    required this.createdTime,
  });
}
