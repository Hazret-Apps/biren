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

  final _descriptionController = TextEditingController();

  String? selectedUserValue;
  String? selectedSubjectValue;
  String? selectedTopicValue;

  int? grade;

  Map<String, dynamic> subjects = {};
  Map<String, dynamic> topics = {};

  Future<void> load() async {
    final selectedUser =
        await FirebaseCollections.users.reference.doc(selectedUserValue).get();
    grade = await selectedUser["grade"];
    int? jsonNumber;

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

    final topicJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/lessons.json');
    final subjectJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/subjects.json');
    final topicData = await json.decode(topicJsonString);
    final subjectData = await json.decode(subjectJsonString);

    setState(() {
      subjects = subjectData[0]["subjects"];
      topics = topicData[jsonNumber]?[grade.toString()]
              ?[selectedSubjectValue] ??
          {"": ""};
    });
  }

  // Map<String, dynamic> topics = {};
  // Map<String, dynamic> subjects = {};
  // String? subjectValue;
  // String? userValue;
  // String? topicValue;
  // String? subject;
  // String? topic;
  // int? grade;

  // Future<void> loadTopic(String userId) async {
  //   int? jsonNumber;

  //   switch (grade) {
  //     case 0:
  //       jsonNumber = 0;
  //       break;
  //     case 5:
  //       jsonNumber = 0;
  //       break;
  //     case 6:
  //       jsonNumber = 1;
  //       break;
  //     case 7:
  //       jsonNumber = 2;
  //       break;
  //     case 8:
  //       jsonNumber = 3;
  //       break;
  //     default:
  //   }

  //   final jsonString = await DefaultAssetBundle.of(context)
  //       .loadString('assets/jsons/study/lessons.json');
  //   final data = json.decode(jsonString);

  //   topic = data[jsonNumber][grade.toString()]?[subject.toString()][topicValue];
  // }

  // Future<void> loadUser(String userId) async {
  //   QuerySnapshot<Object?> userData = await FirebaseCollections.users.reference
  //       .where("uid", isEqualTo: userId)
  //       .get();
  //   grade = userData.docs[0]["grade"];
  //   int? jsonNumber;

  //   switch (grade) {
  //     case 0:
  //       jsonNumber = 0;
  //       break;
  //     case 5:
  //       jsonNumber = 0;
  //       break;
  //     case 6:
  //       jsonNumber = 1;
  //       break;
  //     case 7:
  //       jsonNumber = 2;
  //       break;
  //     case 8:
  //       jsonNumber = 3;
  //       break;
  //     default:
  //   }

  //   final jsonString = await DefaultAssetBundle.of(context)
  //       .loadString('assets/jsons/study/lessons.json');

  //   final jsonStringTwo = await DefaultAssetBundle.of(context)
  //       .loadString('assets/jsons/study/subjects.json');

  //   final data = json.decode(jsonString);
  //   final dataTwo = json.decode(jsonStringTwo);

  //   setState(() {
  //     subjects = dataTwo[0]["subjects"];
  //     topics =
  //         data[jsonNumber][grade.toString()]?[subject.toString()] ?? {"": ""};
  //   });
  // }

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
          _selectUserDropdown(),
          context.emptySizedHeightBoxLow3x,
          DropdownButtonFormField(
            isExpanded: true,
            value: selectedSubjectValue,
            hint: const Text("Ders seçiniz"),
            onChanged: (value) {
              setState(() {
                selectedSubjectValue = value;
                load();
                if (selectedTopicValue != null) {
                  selectedTopicValue = null;
                }
                // subject = subjectValue;
                // if (topicValue != null) {
                //   topicValue = null;
                // }
              });
            },
            items: subjects.entries.map<DropdownMenuItem<String>>((entry) {
              return DropdownMenuItem<String>(
                value: entry.key,
                child: Text(entry.value),
              );
            }).toList(),
          ),
          context.emptySizedHeightBoxLow3x,
          DropdownButtonFormField(
            isExpanded: true,
            value: selectedTopicValue,
            hint: const Text("Konu seçiniz"),
            onChanged: (value) {
              setState(() {
                selectedTopicValue = value;
              });
            },
            items: topics.entries.map<DropdownMenuItem<String>>((entry) {
              return DropdownMenuItem<String>(
                value: entry.value,
                child: Text(entry.value),
              );
            }).toList(),
          ),
          context.emptySizedHeightBoxLow3x,
          _descriptionTextField(),
          context.emptySizedHeightBoxLow3x,
          _button()
        ],
      ),
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
                selectedUserValue = value;
                load();
                if (selectedTopicValue != null) {
                  selectedTopicValue = null;
                }
                // loadUser(userValue!);
                // if (userValue != null) {
                //   subjectValue = null;
                //   topicValue = null;
                // }
              });
            },
            items: userItems,
          );
        }
      },
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
        _addHomework();
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

  void _addHomework() async {
    await FirebaseCollections.users.reference
        .doc(selectedUserValue)
        .collection("homeworks")
        .add({
      "description": _descriptionController.text,
      "userId": selectedUserValue,
      "subject": selectedSubjectValue,
      "topic": selectedTopicValue,
      "date": Timestamp.fromDate(_selectedDate),
    });
  }
}
