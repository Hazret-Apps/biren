import 'dart:io';

import 'package:biren_kocluk/core/model/announcement_card_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncementService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String downloadUrl = "";

  Future<String> uploadImage(XFile image) async {
    var snapshot = await _firebaseStorage
        .ref()
        .child('announcement/${image.name}')
        .putFile(File(image.path));
    downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addAnnouncement(AnnouncementModel announcementModel) async {
    _firebaseFirestore.collection("announcement").add({
      "createdTime": announcementModel.createdTime,
      "description": announcementModel.description,
      "imagePath": announcementModel.imagePath,
      "title": announcementModel.title,
    });
  }
}
