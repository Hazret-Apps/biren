import 'dart:collection';
import 'package:biren_kocluk/features/home/view/homeworks/homeworks_view.dart';
import 'package:biren_kocluk/product/base/view/base_view.dart';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/features/home/viewmodel/home_viewmodel.dart';
import 'package:biren_kocluk/product/model/homework_model.dart';
import 'package:biren_kocluk/product/widget/card/homework_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kartal/kartal.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late DateTime _focusedDay;
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  late Map<DateTime, List<Homework>> _events;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    _events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _focusedDay = DateTime.now();
    _firstDay = DateTime.now().subtract(const Duration(days: 1000));
    _lastDay = DateTime.now().add(const Duration(days: 1000));
    _selectedDay = DateTime.now();
    _loadFirestoreEvents();
  }

  _loadFirestoreEvents() async {
    _events = {};

    final snap = await FirebaseCollections.homeworks.reference
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .withConverter(
            fromFirestore: Homework.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (_events[day] == null) {
        _events[day] = [];
      }
      _events[day]!.add(event);
    }
    setState(() {});
  }

  List<Homework> _getEventsForTheDay(DateTime day) {
    return _events[day] ?? [];
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
              context.emptySizedHeightBoxLow,
              Padding(
                padding: context.horizontalPaddingNormal,
                child: Row(
                  children: [
                    const SelectFeatureCard(
                      color: LightThemeColors.blazeOrange,
                      text: "Ödevler",
                      icon: Icon(
                        Icons.business_center_rounded,
                        color: LightThemeColors.white,
                        size: 50,
                      ),
                      callView: HomeworksView(),
                    ),
                    context.emptySizedWidthBoxNormal,
                    const SelectFeatureCard(
                      color: LightThemeColors.red,
                      text: "Duyurular",
                      icon: FaIcon(
                        FontAwesomeIcons.exclamation,
                        color: LightThemeColors.white,
                        size: 50,
                      ),
                      callView: HomeworksView(),
                    ),
                  ],
                ),
              ),
              context.emptySizedHeightBoxLow,
              Column(
                children: [
                  _calendar,
                  ..._getEventsForTheDay(_selectedDay).map(
                    (event) => HomeworkItem(
                      event: event,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card get _calendar {
    return Card(
      child: TableCalendar(
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        locale: AppConstants.TR_LANG,
        eventLoader: _getEventsForTheDay,
        focusedDay: _focusedDay,
        firstDay: _firstDay,
        lastDay: _lastDay,
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
          _loadFirestoreEvents();
        },
        selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            shape: BoxShape.circle,
            color: LightThemeColors.blazeOrange.withOpacity(.6),
          ),
          selectedDecoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: LightThemeColors.blazeOrange,
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

class SelectFeatureCard extends StatelessWidget {
  const SelectFeatureCard({
    super.key,
    required this.color,
    required this.text,
    required this.icon,
    required this.callView,
  });

  final Color color;
  final String text;
  final Widget icon;
  final Widget callView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => callView,
          ),
        );
      },
      child: Container(
        height: 125,
        width: 125,
        decoration: BoxDecoration(
          color: color,
          borderRadius: context.normalBorderRadius,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(
                4,
                5,
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              text,
              style: const TextStyle(
                color: LightThemeColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}
