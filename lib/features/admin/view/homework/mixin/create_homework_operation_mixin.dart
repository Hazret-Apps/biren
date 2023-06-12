// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/create_homework_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

mixin CreateHomeworkOperationMixin on State<CreateHomeworkView> {
  // HomeworkType homeworkType = HomeworkType.student;
  DateTime? selectedDate;
  String? selectedUserValue;
  // DocumentSnapshot? selectedClass;
  DocumentSnapshot? selectedUser;
  int? grade;
  int? jsonNumber;
  Map<String, dynamic> subjects = {};
  Map<String, dynamic> topics = {};
  String? selectedSubjectValue;
  String? selectedSubjectText;
  String? selectedTopicValue;
  String? selectedGradeValue;

  final Stream<QuerySnapshot> stream = FirebaseCollections.students.reference
      .where("isVerified", isEqualTo: true)
      .snapshots();

  // void changeHelpType(HomeworkType type) => setState(() => homeworkType = type);

  // bool get isClass => homeworkType == HomeworkType.classText;

  Future<void> loadUser() async {
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
      default:
    }
  }

  void addHomework() async {
    await FirebaseCollections.homeworks.reference.add({
      "subject": selectedSubjectText,
      "topic": selectedTopicValue,
      "date": Timestamp.fromDate(selectedDate!),
      "user": selectedUserValue,
      "assignedName": selectedUser!["name"],
      "assignedMail": selectedUser!["mail"],
      "assignedUserID": selectedUser!["uid"],
      "makeEnum": "empty",
    });
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const AdminHomeView(),
      ),
      (route) => false,
    );
  }

  // Future<void> loadClass() async {
  //   selectedClass = await FirebaseCollections.classes.reference
  //       .doc(selectedGradeValue)
  //       .get();

  //   String classText = selectedClass!["name"].toString();

  //   grade = int.parse(classText.characters.first);

  //   switch (grade) {
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
  // }

  Future<void> loadLessons() async {
    final subjectJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/subjects.json');
    final subjectData = await json.decode(subjectJsonString);

    setState(() {
      subjects = subjectData[0]["subjects"];
    });
  }

  Future<void> loadTopics() async {
    final topicJsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/lessons.json');
    final topicData = await json.decode(topicJsonString);

    setState(() {
      topics = topicData[jsonNumber][grade.toString()]?[selectedSubjectValue] ??
          {"": ""};
    });
  }
}
