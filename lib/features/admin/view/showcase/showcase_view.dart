import 'package:biren_kocluk/features/admin/view/showcase/mixin/create_showcase_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/button/main_button.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CreateShowcaseView extends StatefulWidget {
  const CreateShowcaseView({super.key});

  @override
  State<CreateShowcaseView> createState() => _CreateShowcaseViewState();
}

class _CreateShowcaseViewState extends State<CreateShowcaseView>
    with CreateShowcaseOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            children: [
              image == null ? _addPhotoContainer() : _photoContainer(context),
              context.emptySizedHeightBoxLow3x,
              MainTextField(
                hintText: LocaleKeys.titleOptional.tr(),
                keyboardType: TextInputType.name,
                controller: titleController,
              ),
              context.emptySizedHeightBoxLow3x,
              MainButton(
                color: titleController.text == "" || image == null
                    ? LightThemeColors.grey
                    : null,
                onPressed: () async {
                  if (titleController.text == "" || image == null) {
                    return;
                  } else {
                    Navigator.pop(context);
                    var imageUrl =
                        image != null ? await uploadImage(image!) : null;
                    await FirebaseCollections.showcase.reference.add({
                      FirestoreFieldConstants.imageField: imageUrl,
                      FirestoreFieldConstants.titleField:
                          titleController.text.trim(),
                      FirestoreFieldConstants.createdTimeField: Timestamp.now(),
                    });
                  }
                },
                text: LocaleKeys.submit.tr(),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Tanıtım Oluştur"),
    );
  }

  _photoContainer(BuildContext context) {
    return InkWell(
      onTap: () {
        selectImage();
      },
      child: Container(
        height: context.height / 4,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
          color: LightThemeColors.snowbank,
          image: DecorationImage(
            image: FileImage(fileImage!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  InkWell _addPhotoContainer() {
    return InkWell(
      borderRadius: context.normalBorderRadius,
      onTap: () async {
        selectImage();
      },
      child: Container(
        height: context.height / 4,
        width: double.infinity,
        decoration: BoxDecoration(
          color: LightThemeColors.snowbank,
          borderRadius: context.normalBorderRadius,
        ),
        child: const Icon(
          Icons.add_photo_alternate,
          size: 36,
        ),
      ),
    );
  }
}
