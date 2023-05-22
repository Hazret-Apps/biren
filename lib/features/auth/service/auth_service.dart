// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biren_kocluk/main.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
class AuthService {
  static final String? userName =
      FirebaseAuth.instance.currentUser?.displayName;
  static final String? mail = FirebaseAuth.instance.currentUser?.email;
  static final String? userId = FirebaseAuth.instance.currentUser?.uid;

  static const String adminMail = "admin";
  static const String adminPassword = "123";

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerUser(UserModel userModel, BuildContext context) async {
    try {
      _loadingDialog(context);
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.mail.trim(),
        password: userModel.password.trim(),
      );
      await _firebaseAuth.currentUser!.updateDisplayName(userModel.name.trim());
      FirebaseCollections.students.reference
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        "name": userModel.name.trim(),
        "mail": userModel.mail.trim(),
        "password": userModel.password.trim(),
        "createdTime": userModel.createdTime,
        "grade": "Sınıf Yok",
        "class": "Sınıf Yok",
        "isVerified": userModel.isVerified,
        "uid": _firebaseAuth.currentUser!.uid,
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Biren()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        desc: e.message,
      ).show();
    }
  }

  Future<void> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      _loadingDialog(context);

      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Biren()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        desc: e.message,
      ).show();
    }
  }

  Future<dynamic> _loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> logOut(BuildContext context) async {
    _loadingDialog(context);
    _firebaseAuth.signOut().whenComplete(
          () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterView(),
            ),
            (route) => false,
          ),
        );
  }
}
