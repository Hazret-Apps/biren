import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:biren_kocluk/features/admin/view/class/class_detail_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ClassesView extends StatefulWidget {
  const ClassesView({super.key});

  @override
  State<ClassesView> createState() => _ClassesViewState();
}

class _ClassesViewState extends State<ClassesView> {
  final List<String> grades = ["5", "6", "7", "8"];
  final List<String> classes = [
    "A",
    "AA",
    "B",
    "BB",
    "C",
    "CC",
    "D",
    "E",
    "F",
    "G",
    "Ğ",
    "H",
    "I",
    "İ",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "Ö",
    "P",
    "R",
    "S",
    "Ş",
    "T",
    "U",
    "Ü",
    "V",
    "Y",
    "Z"
  ];
  String? selectedGradeNumber;
  String? selectedGradeText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollections.classes.reference
            .orderBy('name', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: context.horizontalPaddingNormal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassDetailView(
                          snapshot: snapshot.data!.docs[index],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: _classText(snapshot, index, context),
                    trailing: _forwardButton(),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text("Sınıflar"),
      actions: [
        GestureDetector(
          onTap: () {
            _createClassBottomSheet(context);
          },
          child: const Icon(Icons.add_circle_outline_rounded),
        ),
        context.emptySizedWidthBoxNormal,
      ],
    );
  }

  GestureDetector _forwardButton() {
    return GestureDetector(
      child: const Icon(Icons.arrow_forward_ios_rounded),
    );
  }

  Text _classText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["name"],
      style: context.textTheme.titleMedium?.copyWith(
        fontSize: 24,
      ),
    );
  }

  Future<void> _createClassBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: context.height / 3,
              width: context.width,
              decoration: BoxDecoration(
                color: LightThemeColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: context.highRadius,
                  topRight: context.highRadius,
                ),
              ),
              child: Padding(
                padding: context.onlyTopPaddingNormal +
                    context.horizontalPaddingNormal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _createClassText(context),
                    context.emptySizedHeightBoxLow3x,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _selectGradeDropdown(setState),
                        Text(
                          "/",
                          style: context.textTheme.titleLarge,
                        ),
                        _selectClassDropdown(setState),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(height: 60, child: _submitButton(context)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Text _createClassText(BuildContext context) {
    return Text(
      "Sınıf Oluştur",
      style: context.textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  DropdownButton<String> _selectGradeDropdown(StateSetter setState) {
    return DropdownButton(
      value: selectedGradeNumber,
      hint: const Text("Sınıf"),
      items: grades.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGradeNumber = value;
        });
      },
    );
  }

  DropdownButton<String> _selectClassDropdown(StateSetter setState) {
    return DropdownButton(
      value: selectedGradeText,
      hint: const Text("Şube"),
      items: classes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedGradeText = value;
        });
      },
    );
  }

  MainButton _submitButton(BuildContext context) {
    return MainButton(
      color: selectedGradeNumber == null || selectedGradeText == null
          ? LightThemeColors.grey
          : null,
      onPressed: () {
        Navigator.pop(context);
        final snackBar = _snackBar();

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        FirebaseCollections.classes.reference
            .add({"name": "$selectedGradeNumber/$selectedGradeText"});
      },
      text: "OLUŞTUR",
    );
  }

  SnackBar _snackBar() {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: "Başarılı!",
        message: 'Sınıf oluşturma işlemi başarılı',
        contentType: ContentType.success,
      ),
    );
  }
}
