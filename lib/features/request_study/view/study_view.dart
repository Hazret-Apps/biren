// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:biren_kocluk/core/enum/firebase_collection_enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StudyView extends StatefulWidget {
  const StudyView({super.key});

  @override
  State<StudyView> createState() => _StudyViewState();
}

class _StudyViewState extends State<StudyView> {
  Map<String, dynamic> topics = {};
  Map<String, dynamic> subjects = {};
  String? subjectValue;
  String? subject;
  String? topicValue;

  Future<void> _loadTopics() async {
    final DocumentSnapshot user = await FirebaseCollections.users.reference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final int grade = user["grade"];
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
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/lessons.json');
    final jsonStringTwo = await DefaultAssetBundle.of(context)
        .loadString('assets/jsons/study/subjects.json');
    final data = json.decode(jsonString);
    final dataTwo = json.decode(jsonStringTwo);
    setState(() {
      subjects = dataTwo[0]["subjects"];
      topics = data[jsonNumber][grade.toString()][subject ?? "turkish"];
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            children: [
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
                items: subjectValue == null
                    ? []
                    : topics.entries.map<DropdownMenuItem<String>>((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
