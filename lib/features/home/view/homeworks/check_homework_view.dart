// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/homework_model.dart';
import 'package:biren_kocluk/product/widget/button/done_action_button.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

class CheckHomeworkView extends StatefulWidget {
  const CheckHomeworkView({Key? key, required this.homework}) : super(key: key);
  final Homework homework;

  @override
  State<CheckHomeworkView> createState() => _CheckHomeworkViewState();
}

class _CheckHomeworkViewState extends State<CheckHomeworkView> {
  XFile? imageXfile;
  File? image;
  TextEditingController descriptionController = TextEditingController();

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String downloadUrl = "";

  Future<String> uploadImage(XFile image) async {
    var snapshot = await _firebaseStorage
        .ref()
        .child('homeworkPush/${image.name}')
        .putFile(File(image.path));
    downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      imageXfile = image;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException {
      return;
    }
  }

  Future<void> onSubmitButton() async {
    Navigator.pop(context);
    downloadUrl = await uploadImage(imageXfile!);
    await FirebaseCollections.homeworks.reference
        .doc(widget.homework.id)
        .update({
      FirestoreFieldConstants.makeEnumField: "pushed",
      FirestoreFieldConstants.imageField: downloadUrl,
      FirestoreFieldConstants.descriptionField: descriptionController.text,
      FirestoreFieldConstants.senderNameField:
          FirebaseAuth.instance.currentUser!.displayName,
      FirestoreFieldConstants.senderMailField:
          FirebaseAuth.instance.currentUser!.email,
      FirestoreFieldConstants.senderUserIDField:
          FirebaseAuth.instance.currentUser!.uid,
      FirestoreFieldConstants.pushedTimeField: Timestamp.now(),
    });
  }

  @override
  void initState() {
    super.initState();
    pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _submitButton(),
          context.emptySizedWidthBoxNormal,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null ? _image(context) : _selectImageButton(),
              context.emptySizedHeightBoxLow3x,
              Padding(
                padding: context.horizontalPaddingNormal,
                child: Column(
                  children: [
                    MainTextField(
                      hintText: LocaleKeys.descriptionOptional.tr(),
                      keyboardType: TextInputType.text,
                      controller: descriptionController,
                      minLines: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DoneActionButton _submitButton() {
    return DoneActionButton(
      color: image != null
          ? LightThemeColors.blazeOrange
          : LightThemeColors.blazeOrange.withOpacity(.6),
      onTap: () {
        image != onSubmitButton() ? null : null;
      },
    );
  }

  Center _selectImageButton() {
    return Center(
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: LightThemeColors.red,
        ),
        onPressed: () {
          pickImage();
        },
        child: Text(LocaleKeys.noPhoto.tr()),
      ),
    );
  }

  GestureDetector _image(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickImage();
      },
      child: SizedBox(
        width: context.width,
        child: Image.file(image!, fit: BoxFit.cover),
      ),
    );
  }
}
