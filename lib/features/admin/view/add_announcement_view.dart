import 'package:biren_kocluk/core/base/view/base_view.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/core/model/announcement_card_model.dart';
import 'package:biren_kocluk/core/widget/text_field/main_text_field.dart';
import 'package:biren_kocluk/features/admin/service/announcement_service.dart';
import 'package:biren_kocluk/features/admin/viewmodel/add_announcement_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  final List<String> greadeList = [
    "5",
    "6",
    "7",
    "8",
  ];
  String? grade;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (model) {
        // model.setContext(context);
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
                hintText: "Duyuru Başlığı",
                keyboardType: TextInputType.name,
                controller: _titleController,
              ),
              context.emptySizedHeightBoxLow3x,
              MainTextField(
                hintText: "Duyuru Açıklaması",
                keyboardType: TextInputType.name,
                controller: _descriptionController,
              ),
              context.emptySizedHeightBoxLow3x,
              _petAgeRangeDropDown
            ],
          ),
        );
      }),
      floatingActionButton: _floatingActionButton(),
    );
  }

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

  DropdownButtonFormField<String> get _petAgeRangeDropDown {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: context.normalBorderRadius,
          borderSide: BorderSide.none,
        ),
      ),
      hint: const Text(
        "Sınıf",
      ),
      value: grade,
      items: greadeList
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (val) {
        setState(() {
          grade = val;
        });
      },
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        var imageUrl = AnnouncementService().uploadImage(viewModel.image!);
        AnnouncementService().addAnnouncement(
          AnnouncementModel(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            createdTime: Timestamp.now(),
            imagePath: viewModel.image == null ? null : await imageUrl,
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  AppBar _appBar() => AppBar(
        title: const Text("Duyuru Oluştur"),
      );
}
