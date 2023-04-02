import 'package:biren_kocluk/core/enum/admin_feature_types.dart';
import 'package:biren_kocluk/core/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AdminSelectFeature extends StatefulWidget {
  const AdminSelectFeature({super.key, required this.featureTypes});

  final AdminFeatureTypes featureTypes;

  @override
  State<AdminSelectFeature> createState() => _AdminSelectFeatureState();
}

class _AdminSelectFeatureState extends State<AdminSelectFeature> {
  late String imagePath;
  late String title;

  @override
  void initState() {
    super.initState();
    switch (widget.featureTypes) {
      case AdminFeatureTypes.announcement:
        imagePath = Assets.images.announcement.path;
        title = "Duyuru Oluştur";
        break;
      case AdminFeatureTypes.task:
        imagePath = Assets.images.task.path;
        title = "Ödev Oluştur";
        break;
      case AdminFeatureTypes.student:
        imagePath = Assets.images.student.path;
        title = "Öğrenciler";
        break;
      case AdminFeatureTypes.login:
        imagePath = Assets.images.login.path;
        title = "Giriş Talepleri";
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: context.height * 0.2,
          width: context.width * 0.4,
          decoration: BoxDecoration(
            color: LightThemeColors.white,
            borderRadius: context.normalBorderRadius,
            image: DecorationImage(
              image: AssetImage(imagePath),
            ),
          ),
        ),
        context.emptySizedHeightBoxLow,
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
      ],
    );
  }
}
