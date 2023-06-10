// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/features/admin/view/create_homework/mixin/create_homework_operation_mixin.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/done_action_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
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
              _dateFormField(),
              context.emptySizedHeightBoxLow3x,
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseCollections.students.reference.snapshots(),
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
                      value: selectedUserValue,
                      isExpanded: true,
                      hint: const Text(
                        "Öğrenci Seç",
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedUserValue = value;
                          loadUser();
                          loadLessons();
                          selectedSubjectText = null;
                          selectedSubjectValue = null;
                          selectedTopicValue = null;
                        });
                      },
                      items: items,
                    );
                  }
                },
              ),
              // isClass
              //     ? SelectTypeDropdown(
              //         selectedValue: selectedGradeValue,
              //         stream: FirebaseCollections.classes.reference
              //             .orderBy('name', descending: false)
              //             .snapshots(),
              //         type: HomeworkType.classText,
              //         onTap: (value) {
              //           setState(() {
              //             selectedGradeValue = value;
              //             loadClass();
              //             selectedSubjectText = null;
              //             selectedSubjectValue = null;
              //             selectedTopicValue = null;
              //             topics = {"": ""};
              //           });
              //         },
              //       )
              //     : SelectTypeDropdown(
              //         selectedValue: selectedUserValue,
              //         stream:
              //             FirebaseCollections.students.reference.snapshots(),
              //         type: HomeworkType.student,
              //         onTap: (value) {
              //           setState(() {
              //             selectedUserValue = value;
              //             loadUser();
              //             selectedSubjectText = null;
              //             selectedSubjectValue = null;
              //             selectedTopicValue = null;
              //           });
              //         },
              //       ),
              context.emptySizedHeightBoxLow3x,
              _selectSubjectDropdown(),
              context.emptySizedHeightBoxLow3x,
              _selectTopicDropdown(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        title: const Text("Ders Programı Oluştur"),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close_rounded),
        ),
        actions: [
          DoneActionButton(
            color: grade == null ||
                    selectedUserValue == null ||
                    selectedDate == null ||
                    jsonNumber == null ||
                    selectedSubjectText == null ||
                    selectedSubjectValue == null ||
                    selectedTopicValue == null
                ? LightThemeColors.blazeOrange.withOpacity(.6)
                : LightThemeColors.blazeOrange,
            onTap: () {
              if (grade == null ||
                  selectedUserValue == null ||
                  selectedDate == null ||
                  jsonNumber == null ||
                  selectedSubjectText == null ||
                  selectedSubjectValue == null ||
                  selectedTopicValue == null) {
                return;
              } else {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
                _addHomework();
              }
            },
          ),
          context.emptySizedWidthBoxNormal,
        ],
      );

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
          selectedDate = date;
        });
      },
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
        }).toList());
  }

  void _addHomework() async {
    await FirebaseCollections.homeworks.reference.add({
      "subject": selectedSubjectText,
      "topic": selectedTopicValue,
      "date": Timestamp.fromDate(selectedDate!),
      "user": selectedUserValue,
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
}

// class _SelectionButton extends StatelessWidget {
//   const _SelectionButton({
//     required this.label,
//     required this.isSelected,
//     required this.onPressed,
//   });

//   final String label;
//   final bool isSelected;
//   final VoidCallback onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           padding: context.paddingNormal,
//           side: BorderSide(
//             color: isSelected
//                 ? LightThemeColors.blazeOrange
//                 : LightThemeColors.snowbank,
//           ),
//         ),
//         onPressed: onPressed,
//         child: FittedBox(
//           child: Text(
//             label,
//             style: context.textTheme.titleSmall?.copyWith(
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TypeSelectionRow extends StatelessWidget {
//   const _TypeSelectionRow(this.selection, {required this.onChanged});

//   final HomeworkType selection;
//   final ValueChanged<HomeworkType> onChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _SelectionButton(
//           label: "Bireysel Ödev",
//           isSelected: selection == HomeworkType.student,
//           onPressed: () => onChanged(HomeworkType.student),
//         ),
//         context.emptySizedWidthBoxLow3x,
//         _SelectionButton(
//           label: "Sınıf Ödev",
//           isSelected: selection == HomeworkType.classText,
//           onPressed: () => onChanged(HomeworkType.classText),
//         ),
//       ],
//     );
//   }
// }

// class SelectTypeDropdown extends StatefulWidget {
//   SelectTypeDropdown({
//     super.key,
//     this.selectedValue,
//     this.stream,
//     this.type,
//     required this.onTap,
//   });

//   String? selectedValue;
//   Stream<QuerySnapshot<Object?>>? stream;
//   HomeworkType? type;
//   final ValueChanged onTap;

//   @override
//   State<SelectTypeDropdown> createState() => _SelectTypeDropdownState();
// }

// class _SelectTypeDropdownState extends State<SelectTypeDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: widget.stream,
//       builder: (context, snapshot) {
//         List<DropdownMenuItem> items = [];
//         if (!snapshot.hasData) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           final users = snapshot.data!.docs.reversed.toList();
//           for (var classes in users) {
//             items.add(
//               DropdownMenuItem(
//                 value: classes.id,
//                 child: Text(
//                   classes["name"],
//                 ),
//               ),
//             );
//           }
//           return DropdownButtonFormField(
//             value: widget.selectedValue,
//             isExpanded: true,
//             hint: Text(
//               widget.type == HomeworkType.classText
//                   ? "Sınıf Seç"
//                   : "Öğrenci Seç",
//             ),
//             onChanged: widget.onTap,
//             items: items,
//           );
//         }
//       },
//     );
//   }
// }
