import 'package:biren_kocluk/features/admin/service/announcement_service.dart';
import 'package:biren_kocluk/features/admin/view/announcement/mixin/create_announcement_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/announcement_card_model.dart';
import 'package:biren_kocluk/product/widget/button/done_action_button.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CreateAnnouncementView extends StatefulWidget {
  const CreateAnnouncementView({super.key});

  @override
  State<CreateAnnouncementView> createState() => _CreateAnnouncementViewState();
}

class _CreateAnnouncementViewState extends State<CreateAnnouncementView>
    with CreateAnnouncementOperationMixin {
  @override
  Widget build(BuildContext context) {
    return _buildScaffold(context);
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: context.horizontalPaddingNormal,
        child: Column(
          children: [
            image == null ? _addPhotoContainer() : _photoContainer(context),
            context.emptySizedHeightBoxLow3x,
            MainTextField(
              hintText: LocaleKeys.titles_announcementTitle.tr(),
              keyboardType: TextInputType.name,
              controller: titleController,
            ),
            context.emptySizedHeightBoxLow3x,
            MainTextField(
              hintText: LocaleKeys.descriptions_announcementDescriptions.tr(),
              keyboardType: TextInputType.name,
              controller: descriptionController,
              minLines: 3,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        title: Text(
          LocaleKeys.features_createAnnouncement.tr(),
        ),
        actions: [
          _doneActionButton(),
          context.emptySizedWidthBoxNormal,
        ],
      );

  DoneActionButton _doneActionButton() {
    return DoneActionButton(
      color: titleController.text != "" && descriptionController.text != ""
          ? LightThemeColors.blazeOrange
          : LightThemeColors.blazeOrange.withOpacity(.6),
      onTap: () async {
        if (titleController.text == "" || descriptionController.text == "") {
          return;
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator.adaptive());
            },
          );
          var imageUrl =
              image != null ? AnnouncementService().uploadImage(image!) : null;
          await AnnouncementService().addAnnouncement(
            AnnouncementModel(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              createdTime: Timestamp.now(),
              imagePath: image == null ? null : await imageUrl,
            ),
            context,
          );
        }
      },
    );
  }

  _photoContainer(BuildContext context) {
    return InkWell(
      onTap: () {
        selectImage();
      },
      child: Container(
        height: 175,
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
        height: 175,
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
