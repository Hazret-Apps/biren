import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class AuthService {
  static final String? userName =
      FirebaseAuth.instance.currentUser?.displayName!;
  static final String? userMail = FirebaseAuth.instance.currentUser?.email!;
  static final String? userId = FirebaseAuth.instance.currentUser?.uid;
}
