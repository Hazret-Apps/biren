import 'package:biren_kocluk/features/auth/login/view/login_view.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:flutter/cupertino.dart';

mixin LoginOperationMixin on State<LoginView> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadAdminLogin();
  }

  Future<void> loadAdminLogin() async {
    var adminLogin = await FirebaseCollections.admin.reference
        .doc(FirestoreFieldConstants.login)
        .get();
    AuthService.adminMail = await adminLogin["mail"];
    AuthService.adminPassword = await adminLogin["password"];
  }

  void callRegisterView(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const RegisterView(),
      ),
      (route) => false,
    );
  }
}
