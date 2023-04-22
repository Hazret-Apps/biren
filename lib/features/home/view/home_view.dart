import 'package:biren_kocluk/product/base/view/base_view.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/product/widget/card/announcement_card.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/viewmodel/home_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (model) {},
      viewModel: HomeViewModel(),
      onPageBuilder: (context, value) => Scaffold(
        appBar: AppBar(
          actions: [
            _signOutButton(context),
          ],
          title: _hiText(context),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseCollections.announcement.reference.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AnnouncementCard(querySnapshot: snapshot);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              Column(
                children: [
                  TableCalendar(
                    locale: "tr_TR",
                    rowHeight: 50,
                    focusedDay: today,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    availableGestures: AvailableGestures.all,
                    firstDay: DateTime.utc(2023, 4, 1),
                    lastDay: DateTime.utc(2023, 5, 31),
                    onDaySelected: _onDaySelected,
                  ),
                  // const StudyCard(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text _hiText(BuildContext context) {
    return Text(
      "${LocaleKeys.hello.tr()}\n${AuthService.userName} 👋",
      style: context.textTheme.titleMedium?.copyWith(
        color: LightThemeColors.black,
        fontSize: 20,
      ),
    );
  }

  IconButton _signOutButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        AuthService().logOut(context);
      },
      icon: const Icon(
        Icons.exit_to_app,
        color: LightThemeColors.black,
      ),
    );
  }
}
