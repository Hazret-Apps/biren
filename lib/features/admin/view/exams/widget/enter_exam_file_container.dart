import 'dart:io';
import 'package:biren_kocluk/features/admin/view/exams/enum/enter_exam_types.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';

class EnterExamFileContainer extends StatefulWidget {
  const EnterExamFileContainer({super.key});

  @override
  State<EnterExamFileContainer> createState() => _EnterExamFileContainerState();
}

class _EnterExamFileContainerState extends State<EnterExamFileContainer> {
  Future<void> loadPdfToStorage(String dowloandUrl) async {
    Navigator.pop(context);
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var fileType = EnterExamFileTypes.file.toString();
    var file = pick.readAsBytesSync();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    var pdfFile = FirebaseStorage.instance.ref().child("exams/$name");
    UploadTask task = pdfFile.putData(file);
    TaskSnapshot snapshot = await task;
    dowloandUrl = await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    String dowloandUrl = "";
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context, dowloandUrl);
      },
      child: Container(
        color: LightThemeColors.snowbank,
        height: context.height / 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate_outlined,
                size: 50,
              ),
              Padding(
                padding:
                    context.horizontalPaddingLow + context.verticalPaddingLow,
                child: Text(
                  "Deneme sonucunun bir ekran görüntüsünü, "
                  "belgesini veya fotoğrafını ekle",
                  style: context.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, String dowloandUrl) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AddFileBottomSheetListTile(
              "Dosya",
              () async {
                loadPdfToStorage(dowloandUrl);
              },
              Icons.insert_drive_file_outlined,
            ),
            _AddFileBottomSheetListTile(
              "Galeri",
              () async {
                XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
              },
              Icons.image_outlined,
            ),
            _AddFileBottomSheetListTile(
              "Kamera",
              () async {
                XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
              },
              Icons.camera_alt_outlined,
            ),
          ],
        );
      },
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
