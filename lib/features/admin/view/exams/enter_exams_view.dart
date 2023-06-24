// ignore_for_file: must_be_immutable

import 'package:biren_kocluk/features/admin/view/exams/mixin/enter_exams_operation_mixin.dart';
import 'package:biren_kocluk/features/admin/view/exams/widget/enter_exam_file_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class EnterExamsView extends StatefulWidget {
  const EnterExamsView({super.key});

  @override
  State<EnterExamsView> createState() => _EnterExamsViewState();
}

class _EnterExamsViewState extends State<EnterExamsView>
    with EnterExamsOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _Body(stream, selectedUserValue),
    );
  }

  AppBar _appBar() => AppBar(
        title: const Text("Deneme Sonucu Gir"),
      );
}

class _Body extends StatefulWidget {
  _Body(this.stream, this.selectedUserValue);

  final Stream<QuerySnapshot> stream;
  String? selectedUserValue;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const EnterExamFileContainer(),
            context.emptySizedHeightBoxLow3x,
            _selectStudentDropdown(context),
          ],
        ),
      ),
    );
  }

  Padding _selectStudentDropdown(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: StreamBuilder<QuerySnapshot>(
        stream: widget.stream,
        builder: (context, snapshot) {
          List<DropdownMenuItem> items = [];
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final users = snapshot.data!.docs.reversed.toList();
            for (var classes in users) {
              items.add(
                DropdownMenuItem(
                  value: classes.id,
                  child: Text(
                    classes["name"],
                  ),
                ),
              );
            }
            return DropdownButtonFormField(
              value: widget.selectedUserValue,
              isExpanded: true,
              hint: const Text(
                "Öğrenci Seç",
              ),
              onChanged: (value) {
                setState(() {
                  widget.selectedUserValue = value;
                });
              },
              items: items,
            );
          }
        },
      ),
    );
  }
}
