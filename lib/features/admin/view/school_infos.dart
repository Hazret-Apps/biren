import 'package:biren_kocluk/features/admin/view/class/classes_view.dart';
import 'package:biren_kocluk/features/admin/view/students/students_view.dart';
import 'package:biren_kocluk/product/gen/assets.gen.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SchoolInfosView extends StatelessWidget {
  const SchoolInfosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dershane Bilgileri"),
      ),
      body: SingleChildScrollView(
        padding: context.horizontalPaddingNormal,
        child: Column(
          children: [
            context.emptySizedHeightBoxLow,
            _myFirstColumn(context),
            context.emptySizedHeightBoxLow,
            const ListTile(
              icon: Icons.group_outlined,
              title: "Öğrenciler",
              callView: StudentsView(),
            ),
            context.emptySizedHeightBoxLow,
            const ListTile(
              icon: Icons.school_outlined,
              title: "Öğretmenler",
              callView: StudentsView(),
            ),
            context.emptySizedHeightBoxLow,
            const ListTile(
              icon: Icons.grade_outlined,
              title: "Sınıflar",
              callView: ClassesView(),
            ),
          ],
        ),
      ),
    );
  }

  Center _myFirstColumn(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _avatar(),
          context.emptySizedHeightBoxLow,
          _nameText(context),
          _descriptionText(),
        ],
      ),
    );
  }

  Text _descriptionText() {
    return const Text(
      '"Birlikte En İyiye"',
      style: TextStyle(
        color: LightThemeColors.grey,
        fontSize: 18,
      ),
    );
  }

  Text _nameText(BuildContext context) {
    return Text(
      "Biren Koçluk",
      style: context.textTheme.titleLarge?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  CircleAvatar _avatar() {
    return CircleAvatar(
      backgroundColor: LightThemeColors.white,
      radius: 95,
      child: SizedBox(
        height: 160,
        width: 160,
        child: Image.asset(Assets.icons.logo.path),
      ),
    );
  }
}

class ListTile extends StatelessWidget {
  const ListTile({
    super.key,
    required this.title,
    required this.callView,
    required this.icon,
  });

  final String title;
  final Widget callView;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => callView),
        );
      },
      child: Row(
        children: [
          Icon(
            icon,
            size: 34,
          ),
          context.emptySizedWidthBoxLow3x,
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => callView),
              );
            },
          ),
        ],
      ),
    );
  }
}
