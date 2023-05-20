// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CreateHomeworkView2 extends StatefulWidget {
  const CreateHomeworkView2({
    super.key,
    required this.studentGrade,
    required this.studentValue,
    required this.selectedDate,
    required this.jsonNumber,
  });

  final int studentGrade;
  final String studentValue;
  final DateTime selectedDate;
  final int jsonNumber;

  @override
  State<CreateHomeworkView2> createState() => _CreateHomeworkView2State();
}

class _CreateHomeworkView2State extends State<CreateHomeworkView2> {
  String? selectedSubjectValue;
  String? selectedSubjectText;
  String? selectedTopicValue;

  Map<String, dynamic> subjects = {};
  Map<String, dynamic> topics = {};

  Future<void> loadLessons() async {
    final topicJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/lessons.json');
    final subjectJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/subjects.json');
    final topicData = await json.decode(topicJsonString);
    final subjectData = await json.decode(subjectJsonString);

    setState(() {
      subjects = subjectData[0]["subjects"];
      topics = topicData[widget.jsonNumber][widget.studentGrade.toString()]
              ?[selectedSubjectValue] ??
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
      appBar: AppBar(
        title: const Text("Ders Ve Konu Seç"),
        actions: [
          _doneIcon(),
          context.emptySizedWidthBoxNormal,
        ],
      ),
      body: SingleChildScrollView(
        padding: context.horizontalPaddingNormal,
        child: Column(
          children: [
            _selectSubjectDropdown(),
            context.emptySizedHeightBoxLow3x,
            _selectTopicDropdown(),
          ],
        ),
      ),
    );
  }

  GestureDetector _doneIcon() {
    return GestureDetector(
      onTap: () {
        if (selectedSubjectValue == null || selectedTopicValue == null) {
          return;
        } else {
          _addHomework();
        }
      },
      child: Icon(
        Icons.done_rounded,
        size: 28,
        color: selectedSubjectValue != null && selectedTopicValue != null
            ? LightThemeColors.blazeOrange
            : LightThemeColors.blazeOrange.withOpacity(.6),
      ),
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
    await FirebaseCollections.users.reference
        .doc(widget.studentValue)
        .collection("homeworks")
        .add({
      "userId": widget.studentValue,
      "subject": selectedSubjectText,
      "topic": selectedTopicValue,
      "date": Timestamp.fromDate(widget.selectedDate),
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
