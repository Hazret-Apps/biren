import 'package:biren_kocluk/core/base/view/base_view.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/gen/assets.gen.dart';
import 'package:biren_kocluk/core/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/core/widget/button/main_button.dart';
import 'package:biren_kocluk/core/widget/text_field/auth_text_field.dart';
import 'package:biren_kocluk/features/auth/login/viewmodel/login_viewmodel.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _mailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  late LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: LoginViewModel(),
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

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Giriş Yap"),
    );
  }

  Image get _birenImage => Image.asset(Assets.icons.icon.path, scale: 1.5 / 1);

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

  AuthButton _loginButton(BuildContext context) {
    return AuthButton(
      onPressed: () {
        if (_mailController.text == AuthService.adminMail &&
            _passwordController.text == AuthService.adminPassword) {
          viewModel.callAdminHomeView();
        }
        if (_formKey.currentState!.validate()) {
          AuthService().loginUser(
            _mailController.text.trim(),
            _passwordController.text.trim(),
            context,
          );
        }
      },
      text: "Giriş Yap",
    );
  }

  Text _alreadyHaveAccount(BuildContext context) {
    return Text(
      "Hesabın yok mu?",
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
        viewModel.callRegisterView();
      },
    );
  }
}
