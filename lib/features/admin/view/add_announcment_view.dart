import 'package:biren_kocluk/core/base/view/base_view.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/core/widget/text_field/main_text_field.dart';
import 'package:biren_kocluk/features/admin/viewmodel/add_announcment_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AddAnnouncmentView extends StatefulWidget {
  const AddAnnouncmentView({super.key});

  @override
  State<AddAnnouncmentView> createState() => _AddAnnouncmentViewState();
}

class _AddAnnouncmentViewState extends State<AddAnnouncmentView> {
  late AddAnnouncmentViewModel viewModel;

  final TextEditingController _titleController = TextEditingController();

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
        model.setContext(context);
        viewModel = model;
      },
      viewModel: AddAnnouncmentViewModel(),
      onPageBuilder: (context, value) => _buildScaffold(context),
    );
  }

  Scaffold _buildScaffold(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        padding: context.horizontalPaddingNormal,
        child: Column(
          children: [
            _addPhotoContainer(),
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
              controller: _titleController,
            ),
            context.emptySizedHeightBoxLow3x,
            _petAgeRangeDropDown
          ],
        ),
      ),
      floatingActionButton: _floatingActionButton(),
    );
  }

  InkWell _addPhotoContainer() {
    return InkWell(
      borderRadius: context.normalBorderRadius,
      onTap: () {
        _bottomSheet(context);
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

  Future<dynamic> _bottomSheet(context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              _pickGalleryButton(context),
              _pickCameraButton(context),
            ],
          ),
        );
      },
    );
  }

  ListTile _pickCameraButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.photo_camera),
      title: const Text("Kamera"),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  ListTile _pickGalleryButton(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.photo_library),
      title: const Text("Galeri"),
      onTap: () {
        Navigator.of(context).pop();
      },
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
      onPressed: () {},
      child: const Icon(Icons.add),
    );
  }

  AppBar _appBar() => AppBar(
        title: const Text("Duyuru Oluştur"),
      );
}
