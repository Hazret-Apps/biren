// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AddEvent extends StatefulWidget {
  final DateTime firstDate;
  final DateTime lastDate;
  const AddEvent({
    Key? key,
    required this.firstDate,
    required this.lastDate,
  }) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DateTime _selectedDate = DateTime.now();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Map<String, dynamic> topics = {};
  Map<String, dynamic> subjects = {};
  List<String> grades = ["5", "6", "7", "8"];
  String? subjectValue;
  String? subject;
  String? topicValue;
  String? gradeValue;

  Future<void> _loadTopics() async {
    final int grade = int.parse(gradeValue ?? "0");
    int? jsonNumber;
    switch (grade) {
      case 0:
        jsonNumber = 0;
        break;
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

    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/lessons.json');

    final jsonStringTwo = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/subjects.json');

    final data = json.decode(jsonString);
    final dataTwo = json.decode(jsonStringTwo);

    setState(() {
      subjects = dataTwo[0]["subjects"];
      topics =
          data[jsonNumber][grade.toString()]?[subject ?? "turkish"] ?? {"": ""};
    });
  }

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ders Programı Oluştur"),
      ),
      body: ListView(
        padding: context.horizontalPaddingNormal,
        children: [
          _dateFormField(),
          context.emptySizedHeightBoxLow3x,
          DropdownButtonFormField(
            isExpanded: true,
            value: gradeValue,
            hint: const Text("Sınıf seçiniz"),
            onChanged: (value) {
              setState(() {
                gradeValue = value;
                topicValue = null;
              });
            },
            items: grades.map<DropdownMenuItem<String>>((entry) {
              return DropdownMenuItem<String>(
                value: entry,
                child: Text(entry),
              );
            }).toList(),
          ),
          context.emptySizedHeightBoxLow3x,
          DropdownButtonFormField(
            isExpanded: true,
            value: subjectValue,
            hint: const Text("Ders seçiniz"),
            onChanged: (value) {
              setState(() {
                subjectValue = value;
                subject = subjectValue;
                _loadTopics();
                if (topicValue != null) {
                  topicValue = null;
                }
              });
            },
            items: subjects.entries.map<DropdownMenuItem<String>>((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value.toString()),
              );
            }).toList(),
          ),
          context.emptySizedHeightBoxLow3x,
          DropdownButtonFormField(
            isExpanded: true,
            value: topicValue,
            hint: const Text("Konu seçiniz"),
            onChanged: (value) {
              setState(() {
                topicValue = value as String?;
              });
            },
            items: subjectValue == null || gradeValue == null
                ? []
                : topics.entries.map<DropdownMenuItem<String>>((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
          ),
          context.emptySizedHeightBoxLow3x,
          _titleTextField(),
          context.emptySizedHeightBoxLow3x,
          _descriptionTextField(),
          context.emptySizedHeightBoxLow3x,
          _button()
        ],
      ),
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
          _selectedDate = date;
        });
      },
    );
  }

  AuthButton _button() {
    return AuthButton(
      onPressed: () {
        _addEvent();
      },
      text: "Kaydet",
    );
  }

  MainTextField _descriptionTextField() {
    return MainTextField(
      hintText: "Açıklama",
      keyboardType: TextInputType.text,
      controller: _descriptionController,
    );
  }

  MainTextField _titleTextField() {
    return MainTextField(
      hintText: "Başlık",
      keyboardType: TextInputType.text,
      controller: _titleController,
    );
  }

  void _addEvent() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isEmpty) {
      return;
    }
    await FirebaseCollections.homeworks.reference.add({
      "title": title,
      "description": description,
      "date": Timestamp.fromDate(_selectedDate),
    });
  }
}
