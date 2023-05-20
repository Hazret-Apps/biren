// ignore_for_file: use_build_context_synchronously

import 'package:biren_kocluk/features/admin/view/create_homework_view_2.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/next_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime? selectedDate;
  String? selectedUserValue;
  int? grade;
  int? jsonNumber;

  Future<void> userLoad() async {
    final selectedUser =
        await FirebaseCollections.users.reference.doc(selectedUserValue).get();
    grade = await selectedUser["grade"] == "Sınıf Yok"
        ? null
        : selectedUser["grade"];

    switch (grade) {
      case 5:
        jsonNumber = 0;
        break;
      case 6:
        jsonNumber = 1;
        break;
      case 7:
        jsonNumber = 2;
        break;
      case 8:
        jsonNumber = 3;
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: ListView(
          padding: context.horizontalPaddingNormal,
          children: [
            _dateFormField(),
            context.emptySizedHeightBoxLow3x,
            _selectUserDropdown(),
            context.emptySizedHeightBoxLow3x,
          ],
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: const Text("Ders Programı Oluştur"),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close_rounded),
        ),
        actions: [
          _nextActionButton(context),
          context.emptySizedWidthBoxNormal,
        ],
      );

  NextActionButton _nextActionButton(BuildContext context) {
    return NextActionButton(
      onTap: () {
        if (grade == null ||
            selectedUserValue == null ||
            selectedDate == null ||
            jsonNumber == null) {
          return;
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (contex) => CreateHomeworkView2(
                studentGrade: grade!,
                studentValue: selectedUserValue!,
                selectedDate: selectedDate!,
                jsonNumber: jsonNumber!,
              ),
            ),
          );
        }
      },
      color: grade != null &&
              selectedUserValue != null &&
              selectedDate != null &&
              jsonNumber != null
          ? LightThemeColors.blazeOrange
          : LightThemeColors.blazeOrange.withOpacity(.6),
    );
  }

  DateTimeFormField _dateFormField() {
    return DateTimeFormField(
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.event_note),
        hintText: "Gün Seçiniz",
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      onDateSelected: (DateTime date) {
        setState(() {
          selectedDate = date;
        });
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> _selectUserDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseCollections.users.reference.snapshots(),
      builder: (context, snapshot) {
        List<DropdownMenuItem> userItems = [];
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final users = snapshot.data!.docs.reversed.toList();
          for (var user in users) {
            userItems.add(
              DropdownMenuItem(
                value: user.id,
                child: Text(
                  user["name"],
                ),
              ),
            );
          }
          return DropdownButtonFormField(
            isExpanded: true,
            value: selectedUserValue,
            hint: const Text("Öğrenci Seçiniz"),
            onChanged: (value) async {
              setState(() {
                userLoad();
                selectedUserValue = value;
                userLoad();
              });
            },
            items: userItems,
          );
        }
      },
    );
  }
}
