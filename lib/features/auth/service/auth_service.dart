import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/core/model/user_model.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:biren_kocluk/features/wait/waiting_view.dart';
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
      FirebaseCollections.users.reference
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        "name": userModel.name.trim(),
        "mail": userModel.mail.trim(),
        "password": userModel.password.trim(),
        "createdTime": userModel.createdTime,
        "isVerified": userModel.isVerified,
        "uid": _firebaseAuth.currentUser!.uid,
      }).whenComplete(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WaitingView()),
          (route) => false,
        );
      });
    } catch (e) {}
  }

  Future<void> loginUser(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      _loadingDialog(context);

      await _firebaseAuth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .whenComplete(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const WaitingView(),
          ),
          (route) => false,
        );
      });
    } catch (e) {}
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
