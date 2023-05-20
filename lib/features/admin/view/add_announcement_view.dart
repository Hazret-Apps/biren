import 'package:biren_kocluk/features/admin/service/announcement_service.dart';
import 'package:biren_kocluk/product/base/view/base_view.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/announcement_card_model.dart';
import 'package:biren_kocluk/product/widget/text_field/main_text_field.dart';
import 'package:biren_kocluk/features/admin/viewmodel/add_announcement_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AddAnnouncementView extends StatefulWidget {
  const AddAnnouncementView({super.key});

  @override
  State<AddAnnouncementView> createState() => _AddAnnouncementViewState();
}

class _AddAnnouncementViewState extends State<AddAnnouncementView> {
  late AddAnnouncementViewModel viewModel;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (model) {
        viewModel = model;
      },
      viewModel: AddAnnouncementViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Observer(builder: (_) {
        return SingleChildScrollView(
          padding: context.horizontalPaddingNormal,
          child: Column(
            children: [
              viewModel.image == null
                  ? _addPhotoContainer()
                  : _photoContainer(context),
              context.emptySizedHeightBoxLow3x,
              MainTextField(
                hintText: LocaleKeys.titles_announcementTitle.tr(),
                keyboardType: TextInputType.name,
                controller: _titleController,
              ),
              context.emptySizedHeightBoxLow3x,
              MainTextField(
                hintText: LocaleKeys.descriptions_announcementDescriptions.tr(),
                keyboardType: TextInputType.name,
                controller: _descriptionController,
                minLines: 3,
                maxLines: 5,
              ),
            ],
          ),
        );
      }),
    );
  }

  AppBar _appBar() => AppBar(
        title: Text(
          LocaleKeys.features_createAnnouncement.tr(),
        ),
        actions: [
          _doneIcon(),
          context.emptySizedWidthBoxNormal,
        ],
      );

  Observer _photoContainer(BuildContext context) {
    return Observer(builder: (_) {
      return InkWell(
        onTap: () {
          viewModel.selectImage();
        },
        child: Container(
          height: 175,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: context.normalBorderRadius,
            color: LightThemeColors.snowbank,
            image: DecorationImage(
              image: FileImage(viewModel.fileImage!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    });
  }

  InkWell _addPhotoContainer() {
    return InkWell(
      borderRadius: context.normalBorderRadius,
      onTap: () async {
        viewModel.selectImage();
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

  GestureDetector _doneIcon() {
    return GestureDetector(
      onTap: () async {
        if (_titleController.text == "" || _descriptionController.text == "") {
          return;
        } else {
          var imageUrl = viewModel.image != null
              ? AnnouncementService().uploadImage(viewModel.image!)
              : null;
          await AnnouncementService().addAnnouncement(
            AnnouncementModel(
              title: _titleController.text.trim(),
              description: _descriptionController.text.trim(),
              createdTime: Timestamp.now(),
              imagePath: viewModel.image == null ? null : await imageUrl,
            ),
            context,
          );
        }
      },
      child: Icon(
        Icons.done_rounded,
        size: 28,
        color: _titleController.text != "" && _descriptionController.text != ""
            ? LightThemeColors.blazeOrange
            : LightThemeColors.blazeOrange.withOpacity(.6),
      ),
    );
  }
}
