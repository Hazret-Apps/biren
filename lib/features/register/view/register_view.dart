import 'package:biren_kocluk/core/gen/assets.gen.dart';
import 'package:biren_kocluk/core/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/core/widget/button/main_button.dart';
import 'package:biren_kocluk/core/widget/text_field/main_text_field.dart';
import 'package:biren_kocluk/features/register/model/user_model.dart';
import 'package:biren_kocluk/features/register/service/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.auth_register.tr()),
      ),
      body: Padding(
        padding: context.horizontalPaddingNormal,
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _birenImage,
                  _nameTextField,
                  context.emptySizedHeightBoxLow3x,
                  _mailTextField,
                  context.emptySizedHeightBoxLow3x,
                  _passwordTextField,
                ],
              ),
            ),
            const Spacer(),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Image get _birenImage => Image.asset(Assets.icons.icon.path, scale: 1.5 / 1);

  AuthTextField get _nameTextField {
    return AuthTextField(
      controller: _nameController,
      hintText: LocaleKeys.auth_nameSurname.tr(),
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person_outline),
    );
  }

  AuthTextField get _mailTextField {
    return AuthTextField(
      controller: _mailController,
      hintText: LocaleKeys.auth_mail.tr(),
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.mail),
    );
  }

  AuthTextField get _passwordTextField {
    return AuthTextField(
      controller: _passwordController,
      hintText: LocaleKeys.auth_password.tr(),
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline),
    );
  }

  AuthButton _registerButton() {
    return AuthButton(
      onPressed: () {
        RegisterService().registerUser(
          UserModel(
            name: _nameController.text,
            mail: _mailController.text,
            password: _passwordController.text,
            createdTime: Timestamp.now(),
          ),
        );
      },
      text: LocaleKeys.auth_register.tr(),
    );
  }
}
