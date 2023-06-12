// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:biren_kocluk/features/admin/view/students/mixin/student_edit_operation_mixin.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StudentEditView extends StatefulWidget {
  const StudentEditView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<StudentEditView> createState() => _StudentEditViewState();
}

class _StudentEditViewState extends State<StudentEditView>
    with StudentEditOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            children: [
              Center(
                child: _avatar(),
              ),
              context.emptySizedHeightBoxLow,
              _nameText(context),
              context.emptySizedHeightBoxLow3x,
              _mailListTile(context),
              _createdDateListTile(context),
              _gradeListTile(context),
              context.emptySizedHeightBoxLow,
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  CircleAvatar _avatar() {
    return CircleAvatar(
      radius: 75,
      backgroundColor: LightThemeColors.blazeOrange.withOpacity(.3),
      child: Text(
        widget.userModel.name.characters.first,
        style: const TextStyle(fontSize: 35),
      ),
    );
  }

  Text _nameText(BuildContext context) {
    return Text(
      widget.userModel.name,
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  ListTile _mailListTile(BuildContext context) {
    return ListTile(
      title: Text(
        "Mail Adresi:",
        style: context.textTheme.titleMedium,
      ),
      trailing: Text(
        widget.userModel.mail,
        style: context.textTheme.bodyLarge,
      ),
    );
  }

  ListTile _createdDateListTile(BuildContext context) {
    return ListTile(
      title: Text(
        "Oluşturulma Zamanı:",
        style: context.textTheme.titleMedium,
      ),
      trailing: Text(
        formattedDate,
        style: context.textTheme.bodyLarge,
      ),
    );
  }

  ListTile _gradeListTile(BuildContext context) {
    return ListTile(
      title: Text(
        "Sınıf:",
        style: context.textTheme.titleMedium,
      ),
      trailing:
          SizedBox(width: context.width / 3, child: _selectClassDropdown()),
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
            hint: Text(widget.userModel.classText ?? "Sınıf Yok"),
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

  SizedBox _submitButton() {
    return SizedBox(
      height: 60,
      child: MainButton(
        color: selectedGradeValue == null ? LightThemeColors.grey : null,
        onPressed: () {
          onSubmitButton();
        },
        text: "KAYDET",
      ),
    );
  }
}
