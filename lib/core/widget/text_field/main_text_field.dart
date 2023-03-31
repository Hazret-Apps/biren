import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.isNext = true,
    this.prefixIcon,
  });

  final String hintText;
  final TextInputType keyboardType;
  final bool isNext;
  final Icon? prefixIcon;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure,
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
