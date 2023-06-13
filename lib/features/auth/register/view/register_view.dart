import 'package:biren_kocluk/features/auth/register/mixin/register_operation_mixin.dart';
import 'package:biren_kocluk/product/gen/assets.gen.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:biren_kocluk/product/widget/text_field/auth_text_field.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    with RegisterOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  Form _body(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: context.horizontalPaddingNormal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _birenImage,
              _nameTextField,
              context.emptySizedHeightBoxLow3x,
              _mailTextField,
              context.emptySizedHeightBoxLow3x,
              _passwordTextField,
              context.emptySizedHeightBoxLow3x,
              _registerButton(context),
              context.emptySizedHeightBoxLow3x,
              _alreadyHaveAccount(context),
              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(LocaleKeys.auth_register.tr()),
    );
  }

  Image get _birenImage => Image.asset(Assets.icons.logo.path, scale: 1.5 / 1);

  AuthTextField get _nameTextField {
    return AuthTextField(
      controller: nameController,
      hintText: LocaleKeys.auth_nameSurname.tr(),
      keyboardType: TextInputType.name,
      prefixIcon: const Icon(Icons.person_outline),
    );
  }

  AuthTextField get _mailTextField {
    return AuthTextField(
      controller: mailController,
      hintText: LocaleKeys.auth_mail.tr(),
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.mail),
    );
  }

  AuthTextField get _passwordTextField {
    return AuthTextField(
      controller: passwordController,
      hintText: LocaleKeys.auth_password.tr(),
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      isLast: true,
    );
  }

  MainButton _registerButton(BuildContext context) {
    return MainButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          AuthService().registerUser(
            UserModel(
              uid: "",
              name: nameController.text,
              mail: mailController.text,
              password: passwordController.text,
              grade: 0,
              createdTime: Timestamp.now(),
              isVerified: false,
            ),
            context,
          );
        }
      },
      text: LocaleKeys.auth_register.tr(),
    );
  }

  Text _alreadyHaveAccount(BuildContext context) {
    return Text(
      LocaleKeys.auth_alreadyHaveAnAccount.tr(),
      style: context.textTheme.titleSmall,
    );
  }

  TextButton _loginButton(BuildContext context) {
    return TextButton(
      child: Text(
        LocaleKeys.auth_login.tr(),
        style: context.textTheme.titleSmall?.copyWith(
          color: LightThemeColors.blazeOrange,
        ),
      ),
      onPressed: () {
        callLoginView(context);
      },
    );
  }
}
