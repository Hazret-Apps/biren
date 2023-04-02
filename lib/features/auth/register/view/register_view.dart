import 'package:biren_kocluk/core/base/view/base_view.dart';
import 'package:biren_kocluk/gen/assets.gen.dart';
import 'package:biren_kocluk/core/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/core/model/user_model.dart';
import 'package:biren_kocluk/core/widget/button/main_button.dart';
import 'package:biren_kocluk/core/widget/text_field/main_text_field.dart';
import 'package:biren_kocluk/features/auth/register/viewmodel/register_viewmodel.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late final RegisterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: RegisterViewModel(),
      onPageBuilder: (context, value) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _appBar(),
        body: _body(context),
      ),
    );
  }

  Form _body(BuildContext context) {
    return Form(
      key: _formKey,
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
      isLast: true,
    );
  }

  AuthButton _registerButton(BuildContext context) {
    return AuthButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          AuthService().registerUser(
            UserModel(
              name: _nameController.text,
              mail: _mailController.text,
              password: _passwordController.text,
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
      "Zaten hesabın var mı?",
      style: context.textTheme.titleSmall,
    );
  }

  TextButton _loginButton(BuildContext context) {
    return TextButton(
      child: Text(
        "Giriş Yap",
        style: context.textTheme.titleSmall?.copyWith(
          color: LightThemeColors.blazeOrange,
        ),
      ),
      onPressed: () {
        viewModel.callLoginView();
      },
    );
  }
}
