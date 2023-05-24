// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/done_action_button.dart';
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
  DocumentSnapshot? selectedUser;
  int? grade;
  int? jsonNumber;

  String? selectedSubjectValue;
  String? selectedSubjectText;
  String? selectedTopicValue;

  Map<String, dynamic> subjects = {};
  Map<String, dynamic> topics = {};

  String? statusMessage;

  Future<void> userLoad() async {
    selectedUser = await FirebaseCollections.students.reference
        .doc(selectedUserValue)
        .get();

    grade = await selectedUser!["grade"] == "Sınıf Yok"
        ? null
        : selectedUser!["grade"];

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
      case null:
        setState(() {
          statusMessage = "Seçtiğiniz Öğrencinin Sınıfı Yok Lütfen Önce";
        });
        break;
      default:
    }
  }

  Future<void> loadLessons() async {
    final topicJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/lessons.json');
    final subjectJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/subjects.json');
    final topicData = await json.decode(topicJsonString);
    final subjectData = await json.decode(subjectJsonString);

    setState(() {
      subjects = subjectData[0]["subjects"];
      topics = topicData[jsonNumber][grade.toString()]?[selectedSubjectValue] ??
          {"": ""};
    });
  }

  @override
  void initState() {
    super.initState();
    loadLessons();
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
            _selectSubjectDropdown(),
            context.emptySizedHeightBoxLow3x,
            _selectTopicDropdown(),
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
          DoneActionButton(
            color: grade == null ||
                    selectedUserValue == null ||
                    selectedDate == null ||
                    jsonNumber == null ||
                    selectedSubjectText == null ||
                    selectedSubjectValue == null ||
                    selectedTopicValue == null
                ? LightThemeColors.blazeOrange.withOpacity(.6)
                : LightThemeColors.blazeOrange,
            onTap: () {
              if (grade == null ||
                  selectedUserValue == null ||
                  selectedDate == null ||
                  jsonNumber == null ||
                  selectedSubjectText == null ||
                  selectedSubjectValue == null ||
                  selectedTopicValue == null) {
                return;
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
                _addHomework();
              }
            },
          ),
          context.emptySizedWidthBoxNormal,
        ],
      );

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
      stream: FirebaseCollections.students.reference.snapshots(),
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
                selectedUserValue = value;
                userLoad();
                selectedSubjectText = null;
                selectedSubjectValue = null;
                selectedTopicValue = null;
              });
            },
            items: userItems,
          );
        }
      },
    );
  }

  DropdownButtonFormField<String> _selectSubjectDropdown() {
    return DropdownButtonFormField(
      isExpanded: true,
      value: selectedSubjectValue,
      hint: const Text("Ders seçiniz"),
      onChanged: (value) {
        setState(() {
          selectedSubjectValue = value;
          switch (selectedSubjectValue) {
            case "turkish":
              selectedSubjectText = "Türkçe";
              break;
            case "math":
              selectedSubjectText = "Matematik";
              break;
            case "science":
              selectedSubjectText = "Fen Bilimleri";
              break;
            case "english":
              selectedSubjectText = "İngilizce";
              break;
            case "regligion":
              selectedSubjectText = "Din";
              break;
            case "social":
              selectedSubjectText = "Sosyal";
              break;
            default:
          }
          loadLessons();
          if (selectedTopicValue != null) {
            selectedTopicValue = null;
          }
        });
      },
      items: subjects.entries.map<DropdownMenuItem<String>>((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
    );
  }

  DropdownButtonFormField<String> _selectTopicDropdown() {
    return DropdownButtonFormField(
      isExpanded: true,
      value: selectedTopicValue,
      hint: const Text("Konu seçiniz"),
      onChanged: (value) {
        setState(() {
          selectedTopicValue = value;
        });
      },
      items: selectedSubjectValue == null
          ? null
          : topics.entries.map<DropdownMenuItem<String>>((entry) {
              return DropdownMenuItem<String>(
                value: entry.value,
                child: Text(entry.value),
              );
            }).toList(),
    );
  }

  void _addHomework() async {
    await FirebaseCollections.students.reference
        .doc(selectedUserValue)
        .collection("homeworks")
        .add({
      "userId": selectedUserValue,
      "subject": selectedSubjectText,
      "topic": selectedTopicValue,
      "date": Timestamp.fromDate(selectedDate!),
    });
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AdminHomeView(),
      ),
      (route) => false,
    );
  }
}
