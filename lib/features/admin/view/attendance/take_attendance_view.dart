import 'package:biren_kocluk/features/admin/view/attendance/mixin/take_attendance_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class TakeAttendanceView extends StatefulWidget {
  const TakeAttendanceView({
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
  State<TakeAttendanceView> createState() => _TakeAttendanceViewState();
}

class _TakeAttendanceViewState extends State<TakeAttendanceView>
    with TakeAttendanceOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
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

  AppBar _appBar() =>
      AppBar(title: Text(LocaleKeys.features_takeAttendance.tr()));

  DropdownButtonFormField<String> _takeStatusDropdown() {
    return DropdownButtonFormField(
      value: statusValueTR,
      isExpanded: true,
      hint: Text(LocaleKeys.selectStatus.tr()),
      onChanged: (String? value) {
        setState(() {
          statusValueTR = value;
          if (statusValueTR == LocaleKeys.came.tr()) {
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
      initialDate: selectedDate,
      onDateSubmitted: (date) {
        setState(() {
          selectedDate = date;
        });
      },
    );
  }

  MainButton _submitButton() {
    return MainButton(
      color: statusValue == null ? LightThemeColors.grey : null,
      onPressed: () {
        statusValue == null ? null : onSubmitButton();
      },
      text: LocaleKeys.submit.tr(),
    );
  }
}
