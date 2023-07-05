import 'package:biren_kocluk/features/admin/view/announcement/announcements_view_admin.dart';
import 'package:biren_kocluk/features/admin/view/attendance/attendance_view.dart';
import 'package:biren_kocluk/features/admin/view/class/classes_view.dart';
import 'package:biren_kocluk/features/admin/view/exams/exams_view.dart';
import 'package:biren_kocluk/features/admin/view/homework/homework_view.dart';
import 'package:biren_kocluk/features/admin/view/students/students_view.dart';
import 'package:biren_kocluk/product/enum/admin_feature_types.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';

class AdminSelectFeature extends StatefulWidget {
  const AdminSelectFeature({super.key, required this.featureTypes});

  final FeatureTypes featureTypes;

  @override
  State<AdminSelectFeature> createState() => _AdminSelectFeatureState();
}

class _AdminSelectFeatureState extends State<AdminSelectFeature> {
  late String imagePath;
  late String title;
  late Widget callView;

  @override
  void initState() {
    super.initState();
    switch (widget.featureTypes) {
      case FeatureTypes.announcement:
        imagePath = Assets.images.announcement.path;
        title = LocaleKeys.features_announcements.tr();
        callView = const AnnouncementsViewAdmin();
        break;
      case FeatureTypes.homeworks:
        imagePath = Assets.images.task.path;
        title = LocaleKeys.features_homeworks.tr();
        callView = const HomeworkView();
        break;
      case FeatureTypes.classes:
        imagePath = Assets.images.classes.path;
        title = LocaleKeys.classes.tr();
        callView = const ClassesView();
        break;
      case FeatureTypes.students:
        imagePath = Assets.images.students.path;
        title = LocaleKeys.features_students.tr();
        callView = const StudentsView();
        break;
      case FeatureTypes.exams:
        imagePath = Assets.images.exams.path;
        title = LocaleKeys.features_exams.tr();
        callView = const ExamsView();
        break;
      case FeatureTypes.attendance:
        imagePath = Assets.images.calender.path;
        title = LocaleKeys.features_attendance.tr();
        callView = const AdminAttendanceView();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => callView,
              ),
            );
          },
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: LightThemeColors.white,
              borderRadius: context.normalBorderRadius,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(
          title,
          style: context.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
