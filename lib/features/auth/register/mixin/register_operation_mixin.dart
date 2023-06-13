import 'package:biren_kocluk/features/auth/login/view/login_view.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:flutter/cupertino.dart';

mixin RegisterOperationMixin on State<RegisterView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void callLoginView(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const LoginView(),
      ),
      (route) => false,
    );
  }
}
