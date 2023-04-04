import 'dart:io';

import 'package:biren_kocluk/core/model/announcement_card_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AnnouncmentService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String downloadUrl = "";

  Future<String> uploadImage(XFile image) async {
    var snapshot = await _firebaseStorage
        .ref()
        .child('announcment/${image.name}')
        .putFile(File(image.path));
    downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> addAnnouncment(AnnouncementModel announcementModel) async {}
}
