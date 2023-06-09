import 'package:biren_kocluk/features/home/view/homeworks/check_homework_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/model/homework_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class HomeworksView extends StatefulWidget {
  const HomeworksView({super.key});

  @override
  State<HomeworksView> createState() => _HomeworksViewState();
}

class _HomeworksViewState extends State<HomeworksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ödevler"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseCollections.homeworks.reference
            .where("user", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return _myHomeworkWidget(context, snapshot, index);
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }

  Padding _myHomeworkWidget(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    DateTime dateTime = snapshot.data!.docs[index]["date"].toDate();
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return Padding(
      padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
      child: Container(
        height: context.height / 5,
        decoration: BoxDecoration(
            color: LightThemeColors.white,
            borderRadius: context.normalBorderRadius,
            boxShadow: [
              BoxShadow(
                color: LightThemeColors.grey.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(
                  5,
                  15,
                ),
              ),
            ]),
        child: Padding(
          padding: context.horizontalPaddingNormal + context.verticalPaddingLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _subjectText(snapshot, index, context),
                  const Spacer(),
                  PopupMenuButton(
                    offset: const Offset(-10, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: context.normalBorderRadius,
                    ),
                    onSelected: (value) {
                      if (value == 0) {
                      } else if (value == 1) {
                      } else if (value == 2) {
                      } else if (value == 3) {
                        _checkDialog(context, snapshot, index);
                      }
                    },
                    itemBuilder: (ctx) => [
                      _buildPopupMenuItem(
                        "Ödev İptal",
                        0,
                        FontAwesomeIcons.exclamation,
                        context,
                      ),
                      _buildPopupMenuItem(
                        "Ertele",
                        1,
                        Icons.alarm_add_rounded,
                        context,
                      ),
                      _buildPopupMenuItem(
                        "Soru Sor",
                        2,
                        Icons.info_outline_rounded,
                        context,
                      ),
                      _buildPopupMenuItem(
                        "Tamamlandı",
                        3,
                        Icons.check_rounded,
                        context,
                      ),
                    ],
                  )
                ],
              ),
              _topicText(snapshot, index, context),
              context.emptySizedHeightBoxLow,
              Text(
                formattedDate,
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkDialog(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, int index) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text("Fotoğraf Çek"),
          content: const Text(
            "Öğretmenlerinin ödevinden emin olabilmesi "
            "için ödevinin fotoğrafını çek",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CheckHomeworkView(
                      homework: Homework(
                        date: snapshot.data!.docs[index]["date"].toDate(),
                        lesson: snapshot.data!.docs[index]["subject"],
                        topic: snapshot.data!.docs[index]["topic"],
                        user: snapshot.data!.docs[index]["user"],
                        makeEnum: snapshot.data!.docs[index]["makeEnum"],
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  ),
                );
              },
              child: const Text(
                "Anladım",
                style: TextStyle(
                  color: LightThemeColors.blazeOrange,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem(
    String title,
    int value,
    IconData iconData,
    BuildContext context,
  ) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          context.emptySizedWidthBoxLow3x,
          Text(title),
        ],
      ),
    );
  }

  Text _subjectText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["subject"],
      style: context.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Text _topicText(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index,
      BuildContext context) {
    return Text(
      snapshot.data!.docs[index]["topic"],
      style: context.textTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
    );
  }
}
