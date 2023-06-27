import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    Key? key,
    required this.firstDate,
    required this.lastDate,
    this.selectedDate,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime? selectedDate;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;

  List<String> statusList = <String>["Geldi", "Gelmedi"];
  String? statusValueTR;
  String? statusValue;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yoklama Al")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            children: [
              context.emptySizedHeightBoxLow,
              _datePicker(),
              context.emptySizedHeightBoxLow3x,
              _takeStatusDropdown(),
              context.emptySizedHeightBoxLow3x,
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  MainButton _submitButton() {
    return MainButton(
      onPressed: () {
        _addEvent();
      },
      text: "Kaydet",
    );
  }

  DropdownButtonFormField<String> _takeStatusDropdown() {
    return DropdownButtonFormField(
      value: statusValueTR,
      isExpanded: true,
      hint: const Text("Durum Seç"),
      onChanged: (String? value) {
        setState(() {
          statusValueTR = value;
          if (statusValueTR == "Geldi") {
            statusValue = "came";
          } else {
            statusValue = "didntCame";
          }
        });
      },
      items: statusList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  InputDatePickerFormField _datePicker() {
    return InputDatePickerFormField(
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      initialDate: _selectedDate,
      onDateSubmitted: (date) {
        setState(() {
          _selectedDate = date;
        });
      },
    );
  }

  void _addEvent() async {
    await FirebaseCollections.attendance.reference.add({
      "name": widget.snapshot.data!.docs[widget.index]["name"],
      "uid": widget.snapshot.data!.docs[widget.index]["uid"],
      "status": statusValue,
      "date": Timestamp.fromDate(_selectedDate),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }
}
