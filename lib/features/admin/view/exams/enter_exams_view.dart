// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:biren_kocluk/features/admin/view/exams/mixin/enter_exams_operation_mixin.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
        title: Text(LocaleKeys.enterExamResult.tr()),
      );
}

class _Body extends StatefulWidget {
  _Body(this.stream, this.selectedStudentValue);

  final Stream<QuerySnapshot> stream;
  String? selectedStudentValue;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  String? fileType;
  XFile? image;
  String dowloadUrl = "";
  File? myPDFFile;
  Uint8List? file;
  String? name;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> loadPdfToStorage() async {
    Navigator.pop(context);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    myPDFFile = File(result!.files.single.path.toString());
    fileType = "file";
    file = myPDFFile!.readAsBytesSync();
    name = DateTime.now().millisecondsSinceEpoch.toString();
    setState(() {});
  }

  Future<void> loadImageToStorage(ImageSource imageSource) async {
    Navigator.pop(context);
    image = await ImagePicker().pickImage(source: imageSource);
    fileType = "image";
    setState(() {});
  }

  GestureDetector enterExamFileContainer() {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: Container(
        height: context.height / 2,
        decoration: BoxDecoration(
          color: LightThemeColors.snowbank,
          image: image != null
              ? DecorationImage(
                  image: FileImage(File(image!.path)),
                )
              : null,
        ),
        child: image == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fileType == "file"
                        ? const SizedBox.shrink()
                        : const Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 50,
                          ),
                    Padding(
                      padding: context.horizontalPaddingNormal +
                          context.verticalPaddingLow,
                      child: Text(
                        LocaleKeys.enterExamFileDescription.tr(),
                        style: context.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddFileBottomSheetListTile(
              LocaleKeys.file.tr(),
              () {
                loadPdfToStorage();
              },
              Icons.insert_drive_file_outlined,
            ),
            _AddFileBottomSheetListTile(
              LocaleKeys.gallery.tr(),
              () {
                loadImageToStorage(ImageSource.gallery);
              },
              Icons.image_outlined,
            ),
            _AddFileBottomSheetListTile(
              LocaleKeys.camera.tr(),
              () {
                loadImageToStorage(ImageSource.camera);
              },
              Icons.camera_alt_outlined,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    PdfViewerController? pdfViewerController;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            fileType == "file"
                ? _pdfViewWidget(context, pdfViewerController)
                : enterExamFileContainer(),
            context.emptySizedHeightBoxLow3x,
            _selectStudentDropdown(context),
            context.emptySizedHeightBoxLow3x,
            _titleTextField(context),
            context.emptySizedHeightBoxLow3x,
            _descriptionTextField(context),
            context.emptySizedHeightBoxLow3x,
            _submitButton(context),
            context.emptySizedHeightBoxNormal,
          ],
        ),
      ),
    );
  }

  GestureDetector _pdfViewWidget(
      BuildContext context, PdfViewerController? pdfViewerController) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
      },
      child: SizedBox(
        height: context.height / 2,
        child: SfPdfViewer.file(
          myPDFFile!,
          controller: pdfViewerController,
        ),
      ),
    );
  }

  Padding _titleTextField(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: MainTextField(
        hintText: LocaleKeys.descriptionOptional.tr(),
        keyboardType: TextInputType.text,
        controller: titleController,
      ),
    );
  }

  Padding _descriptionTextField(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: MainTextField(
        hintText: LocaleKeys.titleOptional.tr(),
        keyboardType: TextInputType.text,
        controller: descriptionController,
        minLines: 4,
      ),
    );
  }

  Padding _submitButton(BuildContext context) {
    return Padding(
      padding: context.horizontalPaddingNormal,
      child: MainButton(
        color: fileType == null || widget.selectedStudentValue == null
            ? LightThemeColors.grey
            : LightThemeColors.blazeOrange,
        onPressed: () {
          onSubmitButton();
        },
        text: LocaleKeys.submit.tr(),
      ),
    );
  }

  Future<void> onSubmitButton() async {
    if (fileType != null && widget.selectedStudentValue != null) {
      Navigator.pop(context);
      if (fileType == "image") {
        var snapshot = await FirebaseStorage.instance
            .ref()
            .child('exams/${image!.name}')
            .putFile(File(image!.path));
        dowloadUrl = await snapshot.ref.getDownloadURL();
      }
      if (fileType == "file") {
        var pdfFile = FirebaseStorage.instance.ref().child("exams/$name");
        UploadTask task = pdfFile.putData(file!);
        TaskSnapshot snapshot = await task;
        dowloadUrl = await snapshot.ref.getDownloadURL();
      }
      FirebaseCollections.exams.reference.add({
        "file": dowloadUrl,
        "student": widget.selectedStudentValue,
        "createdTime": Timestamp.now(),
        "fileType": fileType,
        "description": descriptionController.text,
        "title": titleController.text,
      });
    }
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
              value: widget.selectedStudentValue,
              isExpanded: true,
              hint: Text(LocaleKeys.selectStudent.tr()),
              onChanged: (value) {
                setState(() {
                  widget.selectedStudentValue = value;
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

class _AddFileBottomSheetListTile extends StatelessWidget {
  const _AddFileBottomSheetListTile(
    this.text,
    this.onTap,
    this.icon,
  );

  final String text;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
