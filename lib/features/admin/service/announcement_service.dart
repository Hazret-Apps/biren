import 'dart:io';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/model/announcement_card_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncementService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  String downloadUrl = "";

  Future<String> uploadImage(XFile image) async {
    var snapshot = await _firebaseStorage
        .ref()
        .child('announcement/${image.name}')
        .putFile(File(image.path));
    downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addAnnouncement(
    AnnouncementModel announcementModel,
    context,
  ) async {
    await FirebaseCollections.announcement.reference.add({
      "createdTime": announcementModel.createdTime,
      "description": announcementModel.description,
      "imagePath": announcementModel.imagePath,
      "title": announcementModel.title,
    });
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
