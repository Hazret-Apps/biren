import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/features/auth/login/view/login_view.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:flutter/cupertino.dart';

mixin LoginOperationMixin on State<LoginView> {
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void callRegisterView(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const RegisterView(),
      ),
      (route) => false,
    );
  }

  void callAdminHomeView(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const AdminHomeView(),
      ),
      (route) => false,
    );
  }
}
