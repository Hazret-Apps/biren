import 'dart:io';
import 'package:biren_kocluk/features/admin/view/announcement/create_announcement_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

mixin CreateAnnouncementOperationMixin on State<CreateAnnouncementView> {
  XFile? image;
  File? fileImage;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> selectImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      fileImage = File(image!.path);
    });
  }
}
