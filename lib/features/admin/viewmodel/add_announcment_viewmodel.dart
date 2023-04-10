// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'add_announcment_viewmodel.g.dart';

class AddAnnouncmentViewModel = _AddAnnouncmentViewModelBase
    with _$AddAnnouncmentViewModel;

abstract class _AddAnnouncmentViewModelBase with Store {
  // @override
  // void setContext(BuildContext context) {
  //   viewModelContext = context;
  // }

  // @override
  // void init() {}

  @observable
  XFile? image;

  @observable
  File? fileImage;

  @action
  Future<void> selectImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    fileImage = File(image!.path);
  }
}
