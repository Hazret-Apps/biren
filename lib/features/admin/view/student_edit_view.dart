// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/user_model.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class StudentEditView extends StatefulWidget {
  const StudentEditView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<StudentEditView> createState() => _StudentEditViewState();
}

class _StudentEditViewState extends State<StudentEditView> {
  late final String formattedDate;
  final List<String> grades = ["5", "6", "7", "8"];
  String? selectedGradeValue;

  @override
  void initState() {
    super.initState();
    formattedDate = DateFormat(
      DateFormat.YEAR_MONTH_DAY,
      "tr_TR",
    ).format(widget.userModel.createdTime.toDate());
  }

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
      trailing: DropdownButton(
        value: selectedGradeValue,
        hint: Text(widget.userModel.grade.toString()),
        items: grades.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedGradeValue = value;
          });
        },
      ),
    );
  }

  SizedBox _submitButton() {
    return SizedBox(
      height: 60,
      child: AuthButton(
        onPressed: () {
          if (selectedGradeValue != null) {
            FirebaseCollections.users.reference
                .doc(widget.userModel.uid)
                .update({
              "grade": int.parse(selectedGradeValue!),
            });
            Navigator.pop(context);
          }
        },
        text: "KAYDET",
      ),
    );
  }
}
