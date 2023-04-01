import 'package:biren_kocluk/core/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/core/init/validation/regex_validations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.isLast = false,
    this.prefixIcon,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isLast;
  final Icon? prefixIcon;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool isObscure;

  @override
  void initState() {
    super.initState();
    isObscure =
        widget.keyboardType == TextInputType.visiblePassword ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction:
          widget.isLast ? TextInputAction.done : TextInputAction.next,
      keyboardType: widget.keyboardType,
      obscureText: isObscure,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: LightThemeColors.black,
        filled: true,
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? _eyeIcon()
            : null,
        fillColor: LightThemeColors.snowbank,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: context.normalBorderRadius,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.validatons_emptyValidation.tr();
        }
        if (widget.keyboardType == TextInputType.emailAddress) {
          if (!RegexValidations.instance.emailRegex.hasMatch(value)) {
            return LocaleKeys.validatons_mailValidation.tr();
          }
        }
        return null;
      },
    );
  }

  Widget _eyeIcon() {
    return IconButton(
      icon: const Icon(Icons.remove_red_eye_outlined),
      splashRadius: 1,
      onPressed: () {
        setState(() {
          isObscure = !isObscure;
        });
      },
    );
  }
}
