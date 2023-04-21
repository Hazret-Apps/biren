import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
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
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        prefixIconColor: LightThemeColors.black,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return LocaleKeys.validatons_emptyValidation.tr();
        }
        return null;
      },
    );
  }
}
