import 'package:biren_kocluk/features/admin/view/students/mixin/login_accept_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class LoginAcceptView extends StatefulWidget {
  const LoginAcceptView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<LoginAcceptView> createState() => _LoginAcceptViewState();
}

class _LoginAcceptViewState extends State<LoginAcceptView>
    with LoginAcceptOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        padding: context.horizontalPaddingNormal,
        child: Column(
          children: [
            MyListTile(
              hint: LocaleKeys.auth_name.tr(),
              trailingHint: widget.userModel.name,
            ),
            context.emptySizedHeightBoxLow3x,
            MyListTile(
              hint: LocaleKeys.auth_mailAddress.tr(),
              trailingHint: widget.userModel.mail,
            ),
            context.emptySizedHeightBoxLow3x,
            MyListTile(
              hint: LocaleKeys.auth_creationTime.tr(),
              trailingHint: formattedDate,
            ),
            context.emptySizedHeightBoxLow,
            MyListTile(
              hint: LocaleKeys.classText.tr(),
              trailing: _selectClassDropdown(),
            ),
            context.emptySizedHeightBoxLow3x,
            MainTextField(
              hintText: LocaleKeys.auth_studentPhone.tr(),
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_rounded),
              controller: studentPhone,
            ),
            context.emptySizedHeightBoxLow3x,
            MainTextField(
              hintText: LocaleKeys.auth_parentPhone.tr(),
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_rounded),
              controller: parentPhone,
            ),
            context.emptySizedHeightBoxLow3x,
            MainButton(
              onPressed: () {
                onSubmitButton();
              },
              text: LocaleKeys.admitIt.tr(),
              color: selectedGradeValue == null ? LightThemeColors.grey : null,
            )
          ],
        ),
      ),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: Text(
        LocaleKeys.acceptStudent.tr(),
        style: const TextStyle(color: LightThemeColors.green),
      ),
      foregroundColor: LightThemeColors.green,
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _selectClassDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        List<DropdownMenuItem> classItems = [];
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final users = snapshot.data!.docs.reversed.toList();
          for (var classes in users) {
            classItems.add(
              DropdownMenuItem(
                value: classes["name"],
                child: Text(
                  classes["name"],
                ),
              ),
            );
          }
          return DropdownButton(
            value: selectedGradeValue,
            hint: Text(LocaleKeys.selectClass.tr()),
            onChanged: (value) async {
              setState(() {
                selectedGradeValue = value;
              });
            },
            items: classItems,
          );
        }
      },
    );
  }
}

class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.hint,
    this.trailing,
    this.trailingHint,
  });

  final String hint;
  final Widget? trailing;
  final String? trailingHint;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          hint,
          style: context.textTheme.titleMedium?.copyWith(fontSize: 18),
        ),
        const Spacer(),
        trailing == null ? const SizedBox.shrink() : trailing!,
        trailingHint == null
            ? const SizedBox.shrink()
            : Text(
                trailingHint!,
                style: context.textTheme.titleMedium?.copyWith(fontSize: 18),
              )
      ],
    );
  }
}
