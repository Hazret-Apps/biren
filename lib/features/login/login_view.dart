import 'package:biren_kocluk/core/gen/assets.gen.dart';
import 'package:biren_kocluk/core/widget/button/main_button.dart';
import 'package:biren_kocluk/core/widget/text_field/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Kayıt Ol"),
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
    return const AuthTextField(
      hintText: "Ad Soyad",
      keyboardType: TextInputType.name,
      prefixIcon: Icon(Icons.person_outline),
    );
  }

  AuthTextField get _mailTextField {
    return const AuthTextField(
      hintText: "Mail",
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icon(Icons.mail),
    );
  }

  AuthTextField get _passwordTextField {
    return const AuthTextField(
      hintText: "Şifre",
      keyboardType: TextInputType.visiblePassword,
      prefixIcon: Icon(Icons.lock_outline),
    );
  }

  AuthButton _registerButton() {
    return AuthButton(
      onPressed: () {},
      text: "Kayıt Ol",
    );
  }
}
