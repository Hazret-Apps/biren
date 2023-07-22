// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/create_homework_view.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/enum/homework_type_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

mixin CreateHomeworkOperationMixin on State<CreateHomeworkView> {
  HomeworkType homeworkType = HomeworkType.student;
  DateTime? selectedDate;
  String? selectedUserValue;
  DocumentSnapshot? selectedClass;
  DocumentSnapshot? selectedUser;
  int? grade;
  int? jsonNumber;
  Map<String, dynamic> subjects = {};
  Map<String, dynamic> topics = {};
  String? selectedSubjectValue;
  String? selectedSubjectText;
  String? selectedTopicValue;
  String? selectedGradeValue;
  TextEditingController descriptionController = TextEditingController();

  final Stream<QuerySnapshot> studentsStream = FirebaseCollections
      .students.reference
      .where(FirestoreFieldConstants.isVerifiedField, isEqualTo: true)
      .snapshots();

  final Stream<QuerySnapshot> classesStream =
      FirebaseCollections.classes.reference.snapshots();

  void changeHelpType(HomeworkType type) {
    setState(() => homeworkType = type);
    selectedClass = null;
    selectedUser = null;
    selectedUserValue = null;
    selectedGradeValue = null;
    subjects = {};
    topics = {};
  }

  bool get isClass => homeworkType == HomeworkType.classText;

  Future<void> loadUser() async {
    selectedUser = await FirebaseCollections.students.reference
        .doc(selectedUserValue)
        .get();

    grade = await selectedUser![FirestoreFieldConstants.gradeField] ==
            LocaleKeys.noClass.tr()
        ? null
        : selectedUser![FirestoreFieldConstants.gradeField];

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

    loadLessons();
  }

  Future<void> loadClass() async {
    selectedClass = await FirebaseCollections.classes.reference
        .doc(selectedGradeValue)
        .get();

    String classText =
        selectedClass![FirestoreFieldConstants.nameField].toString();

    grade = int.parse(classText.characters.first);

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
    topics = {"": ""};
    loadLessons();
  }

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

  void addHomework() async {
    await FirebaseCollections.homeworks.reference.add({
      FirestoreFieldConstants.subjectField: selectedSubjectText,
      FirestoreFieldConstants.topicField: selectedTopicValue,
      FirestoreFieldConstants.dateField: Timestamp.fromDate(selectedDate!),
      FirestoreFieldConstants.assignedIdField: isClass
          ? selectedGradeValue
          : selectedUser![FirestoreFieldConstants.uidField],
      FirestoreFieldConstants.typeField: isClass
          ? FirestoreFieldConstants.classField
          : FirestoreFieldConstants.studentField,
      FirestoreFieldConstants.makeEnumField: FirestoreFieldConstants.emptyField,
      FirestoreFieldConstants.assignedNameField: isClass
          ? selectedClass![FirestoreFieldConstants.nameField]
          : selectedUser![FirestoreFieldConstants.nameField],
      FirestoreFieldConstants.descriptionField: descriptionController.text,
    });
    Navigator.pushAndRemoveUntil(
      context,
      CupertinoPageRoute(
        builder: (context) => const AdminHomeView(),
      ),
      (route) => false,
    );
  }
}
