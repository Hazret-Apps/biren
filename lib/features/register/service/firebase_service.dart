import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/features/register/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class RegisterService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerUser(UserModel userModel) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.mail.trim(),
        password: userModel.password.trim(),
      );
      _firebaseAuth.currentUser!.updateDisplayName(userModel.name.trim());
      FirebaseCollections.users.reference.add({
        "name": userModel.name.trim(),
        "mail": userModel.mail.trim(),
        "password": userModel.password.trim(),
        "createdTime": userModel.createdTime,
      });
    } catch (e) {}
  }
}
