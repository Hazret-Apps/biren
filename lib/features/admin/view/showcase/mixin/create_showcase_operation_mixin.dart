import 'dart:io';

import 'package:biren_kocluk/features/admin/view/showcase/showcase_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

mixin CreateShowcaseOperationMixin on State<CreateShowcaseView> {
  XFile? image;
  File? fileImage;

  final TextEditingController titleController = TextEditingController();

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  String downloadUrl = "";

  Future<String> uploadImage(XFile image) async {
    var snapshot = await _firebaseStorage
        .ref()
        .child('showcase/${image.name}')
        .putFile(File(image.path));
    downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> selectImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      fileImage = File(image!.path);
    });
  }
}
