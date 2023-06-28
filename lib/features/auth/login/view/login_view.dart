import 'package:biren_kocluk/features/auth/login/mixin/login_operation_mixin.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:biren_kocluk/product/widget/text_field/auth_text_field.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              context.emptySizedHeightBoxHigh,
              Text(
                "Tekrar Hoşgeldin!",
                style: context.textTheme.bodyMedium?.copyWith(fontSize: 24),
              ),
              context.emptySizedHeightBoxLow,
              Text(
                "Seni tekrar gördüğümüze çok \nsevindik",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium
                    ?.copyWith(color: LightThemeColors.grey),
              ),
              context.emptySizedHeightBoxNormal,
              _mailTextField,
              context.emptySizedHeightBoxLow3x,
              _passwordTextField,
              context.emptySizedHeightBoxLow3x,
              _loginButton(context),
              context.emptySizedHeightBoxLow3x,
              _alreadyHaveAccount(context),
              _registerButton(context),
            ],
          ),
        ),
      ),
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

  MainButton _loginButton(BuildContext context) {
    return MainButton(
      onPressed: () {
        //! Admin test hızlı olsun diye böyle, ayrı bir uygulamaya taşınacak
        if (mailController.text == AuthService.adminMail &&
            passwordController.text == AuthService.adminPassword) {
          callAdminHomeView(context);
        }
        if (formKey.currentState!.validate()) {
          AuthService().loginUser(
            mailController.text.trim(),
            passwordController.text.trim(),
            context,
          );
        }
      },
      text: LocaleKeys.auth_login.tr(),
    );
  }

  Text _alreadyHaveAccount(BuildContext context) {
    return Text(
      LocaleKeys.auth_dontHaveAnAccount.tr(),
      style: context.textTheme.titleSmall,
    );
  }

  TextButton _registerButton(BuildContext context) {
    return TextButton(
      child: Text(
        LocaleKeys.auth_register.tr(),
        style: context.textTheme.titleSmall?.copyWith(
          color: LightThemeColors.blazeOrange,
        ),
      ),
      onPressed: () {
        callRegisterView(context);
      },
    );
  }
}
