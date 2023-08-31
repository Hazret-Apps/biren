// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/features/auth/login/view/login_view.dart';
import 'package:biren_kocluk/main.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class AuthService {
  static String? userName = FirebaseAuth.instance.currentUser?.displayName;
  static String? mail = FirebaseAuth.instance.currentUser?.email;
  static String? userId = FirebaseAuth.instance.currentUser?.uid;
  static String? userClassId;

  static String? adminMail;
  static String? adminPassword;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> loginAdmin(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("adminLogin", true);
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const AdminHomeView(),
      ),
      (route) => false,
    );
  }

  Future<void> logOutAdmin(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const LoginView(),
      ),
      (route) => false,
    );
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("adminLogin", false);
  }

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
        FirestoreFieldConstants.nameField: userModel.name.trim(),
        FirestoreFieldConstants.mailField: userModel.mail.trim(),
        FirestoreFieldConstants.passwordField: userModel.password.trim(),
        FirestoreFieldConstants.createdTimeField: userModel.createdTime,
        FirestoreFieldConstants.gradeField: "Sınıf Yok",
        FirestoreFieldConstants.classField: "Sınıf Yok",
        FirestoreFieldConstants.isVerifiedField: userModel.isVerified,
        FirestoreFieldConstants.uidField: _firebaseAuth.currentUser!.uid,
      });
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
            builder: (context) => const Biren(adminLogin: false)),
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

  Future<void> loadUserClass() async {
    DocumentSnapshot<Object?> user = await FirebaseCollections
        .students.reference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    String userClassName = await user[FirestoreFieldConstants.classField];
    var userClass = await FirebaseCollections.classes.reference
        .where(FirestoreFieldConstants.nameField, isEqualTo: userClassName)
        .get();
    AuthService.userClassId = userClass.docs.first.id;
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
      loadUserClass();
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => const Biren(adminLogin: false),
        ),
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
        return const Center(child: CircularProgressIndicator.adaptive());
      },
    );
  }

  Future<void> logOut(BuildContext context) async {
    Navigator.pop(context);
    _firebaseAuth.signOut().whenComplete(() {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(
          builder: (context) => const RegisterView(),
        ),
        (route) => false,
      );
    });
  }

  Future<void> deleteAccount(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const RegisterView(),
      ),
      (route) => false,
    );
    FirebaseCollections.students.reference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
    FirebaseAuth.instance.currentUser!.delete();
  }
}
