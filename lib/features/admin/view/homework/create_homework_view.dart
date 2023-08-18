// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:biren_kocluk/features/admin/view/homework/mixin/create_homework_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/enum/homework_type_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CreateHomeworkView extends StatefulWidget {
  const CreateHomeworkView({Key? key}) : super(key: key);

  @override
  State<CreateHomeworkView> createState() => _CreateHomeworkViewState();
}

class _CreateHomeworkViewState extends State<CreateHomeworkView>
    with CreateHomeworkOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            children: [
              context.emptySizedHeightBoxLow,
              _TypeSelectionRow(homeworkType, onChanged: changeHelpType),
              context.emptySizedHeightBoxLow3x,
              _dateFormField(),
              context.emptySizedHeightBoxLow3x,
              isClass
                  ? SelectTypeDropdown(
                      selectedValue: selectedGradeValue,
                      stream: FirebaseCollections.classes.reference
                          .orderBy('name', descending: false)
                          .snapshots(),
                      type: HomeworkType.classText,
                      onTap: (value) {
                        setState(() {
                          selectedGradeValue = value;
                          loadClass();
                          selectedSubjectText = null;
                          selectedSubjectValue = null;
                          selectedTopicValue = null;
                          topics = {"": ""};
                        });
                      },
                    )
                  : SelectTypeDropdown(
                      selectedValue: selectedUserValue,
                      stream:
                          FirebaseCollections.students.reference.snapshots(),
                      type: HomeworkType.student,
                      onTap: (value) {
                        setState(() {
                          selectedUserValue = value;
                          loadUser();
                          selectedSubjectText = null;
                          selectedSubjectValue = null;
                          selectedTopicValue = null;
                        });
                      },
                    ),
              context.emptySizedHeightBoxLow3x,
              _selectSubjectDropdown(),
              context.emptySizedHeightBoxLow3x,
              _selectTopicDropdown(),
              context.emptySizedHeightBoxLow3x,
              MainTextField(
                hintText: LocaleKeys.descriptionOptional.tr(),
                keyboardType: TextInputType.text,
                controller: descriptionController,
                minLines: 3,
              ),
              context.emptySizedHeightBoxLow3x,
              MainButton(
                color: isClass
                    ? selectedClass == null ||
                            selectedDate == null ||
                            selectedSubjectValue == null ||
                            selectedTopicValue == null
                        ? LightThemeColors.grey
                        : null
                    : selectedDate == null ||
                            selectedSubjectValue == null ||
                            selectedTopicValue == null ||
                            selectedUserValue == null
                        ? LightThemeColors.grey
                        : null,
                onPressed: () {
                  if (isClass) {
                    if (selectedGradeValue != null &&
                        selectedTopicValue != null &&
                        selectedSubjectValue != null) {
                      addHomework();
                    }
                  } else {
                    if (selectedDate != null &&
                        selectedSubjectValue != null &&
                        selectedTopicValue != null &&
                        selectedUserValue != null) {
                      addHomework();
                    }
                  }
                },
                text: LocaleKeys.submit.tr(),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: Text(LocaleKeys.features_createHomework.tr()),
      );

  DateTimeFormField _dateFormField() {
    return DateTimeFormField(
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.event_note),
        hintText: LocaleKeys.selectDay.tr(),
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      onDateSelected: (DateTime date) {
        setState(() {
          selectedDate = date;
        });
      },
    );
  }

  DropdownButtonFormField<String> _selectSubjectDropdown() {
    return DropdownButtonFormField(
      isExpanded: true,
      value: selectedSubjectValue,
      hint: Text(
        LocaleKeys.selectSubject.tr(),
        style: const TextStyle(
          fontFamily: "Poppins",
          color: LightThemeColors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
      onChanged: (value) {
        setState(() {
          selectedSubjectValue = value;
          switch (selectedSubjectValue) {
            case "turkish":
              selectedSubjectText = LocaleKeys.subjects_turkish.tr();
              break;
            case "math":
              selectedSubjectText = LocaleKeys.subjects_math.tr();
              break;
            case "science":
              selectedSubjectText = LocaleKeys.subjects_science.tr();
              break;
            case "english":
              selectedSubjectText = LocaleKeys.subjects_english.tr();
              break;
            case "regligion":
              selectedSubjectText = LocaleKeys.subjects_regligion.tr();
              break;
            case "social":
              selectedSubjectText = LocaleKeys.subjects_social.tr();
              break;
            default:
          }
          loadTopics();
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
        hint: Text(
          LocaleKeys.selectTopic.tr(),
          style: const TextStyle(
            fontFamily: "Poppins",
            color: LightThemeColors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        }).toList());
  }
}

class _SelectionButton extends StatelessWidget {
  const _SelectionButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: context.paddingNormal,
          side: BorderSide(
            color: isSelected
                ? LightThemeColors.blazeOrange
                : LightThemeColors.snowbank,
          ),
        ),
        onPressed: onPressed,
        child: FittedBox(
          child: Text(
            label,
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeSelectionRow extends StatelessWidget {
  const _TypeSelectionRow(this.selection, {required this.onChanged});

  final HomeworkType selection;
  final ValueChanged<HomeworkType> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _SelectionButton(
          label: LocaleKeys.individualHomework.tr(),
          isSelected: selection == HomeworkType.student,
          onPressed: () => onChanged(HomeworkType.student),
        ),
        context.emptySizedWidthBoxLow3x,
        _SelectionButton(
          label: LocaleKeys.classHomework.tr(),
          isSelected: selection == HomeworkType.classText,
          onPressed: () => onChanged(HomeworkType.classText),
        ),
      ],
    );
  }
}

class SelectTypeDropdown extends StatefulWidget {
  SelectTypeDropdown({
    super.key,
    this.selectedValue,
    this.stream,
    this.type,
    required this.onTap,
  });

  String? selectedValue;
  Stream<QuerySnapshot<Object?>>? stream;
  HomeworkType? type;
  final ValueChanged onTap;

  @override
  State<SelectTypeDropdown> createState() => _SelectTypeDropdownState();
}

class _SelectTypeDropdownState extends State<SelectTypeDropdown> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.stream,
      builder: (context, snapshot) {
        List<DropdownMenuItem> items = [];
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          final users = snapshot.data!.docs.reversed.toList();
          for (var classes in users) {
            items.add(
              DropdownMenuItem(
                value: classes.id,
                child: Text(
                  classes[FirestoreFieldConstants.nameField],
                ),
              ),
            );
          }
          return DropdownButtonFormField(
            value: widget.selectedValue,
            isExpanded: true,
            hint: Text(
              widget.type == HomeworkType.classText
                  ? LocaleKeys.selectClass.tr()
                  : LocaleKeys.selectStudent.tr(),
              style: const TextStyle(
                fontFamily: "Poppins",
                color: LightThemeColors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            onChanged: widget.onTap,
            items: items,
          );
        }
      },
    );
  }
}
