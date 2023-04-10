// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_announcement_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddAnnouncementViewModel on _AddAnnouncmentViewModelBase, Store {
  late final _$imageAtom =
      Atom(name: '_AddAnnouncmentViewModelBase.image', context: context);

  @override
  XFile? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(XFile? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$fileImageAtom =
      Atom(name: '_AddAnnouncmentViewModelBase.fileImage', context: context);

  @override
  File? get fileImage {
    _$fileImageAtom.reportRead();
    return super.fileImage;
  }

  @override
  set fileImage(File? value) {
    _$fileImageAtom.reportWrite(value, super.fileImage, () {
      super.fileImage = value;
    });
  }

  late final _$selectImageAsyncAction =
      AsyncAction('_AddAnnouncmentViewModelBase.selectImage', context: context);

  @override
  Future<void> selectImage() {
    return _$selectImageAsyncAction.run(() => super.selectImage());
  }

  @override
  String toString() {
    return '''
image: ${image},
fileImage: ${fileImage}
    ''';
  }
}
