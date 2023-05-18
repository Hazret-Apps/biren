// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

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
          ?[selectedSubjectValue];
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

  // void _addHomework() async {
  //   await FirebaseCollections.users.reference
  //       .doc(selectedUserValue)
  //       .collection("homeworks")
  //       .add({
  //     "description": _descriptionController.text,
  //     "userId": selectedUserValue,
  //     "subject": selectedSubjectText,
  //     "topic": selectedTopicValue,
  //     "date": Timestamp.fromDate(_selectedDate),
  //   });
  //   Navigator.pop(context);
  // }
}
