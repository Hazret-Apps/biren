import 'package:biren_kocluk/features/home/view/announcement/announcements_view.dart';
import 'package:biren_kocluk/features/home/view/homeworks/homeworks_view.dart';
import 'package:biren_kocluk/features/home/mixin/home_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/product/widget/card/homework_card_mini.dart';
import 'package:easy_localization/easy_localization.dart';
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

class _HomeViewState extends State<HomeView> with HomeOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
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
                  callView: AnnouncementView(),
                ),
              ],
            ),
          ),
          context.emptySizedHeightBoxLow,
          Column(
            children: [
              _calendar,
              ...getEventsForTheDay(selectedDay).map(
                (event) => HomeworkItem(
                  event: event,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      actions: [
        _signOutButton(context),
      ],
      title: _hiText(context),
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
        eventLoader: getEventsForTheDay,
        focusedDay: focusedDay,
        firstDay: firstDay,
        lastDay: lastDay,
        onPageChanged: (focusedDay) {
          setState(() {
            focusedDay = focusedDay;
          });
          loadFirestoreEvents();
        },
        selectedDayPredicate: (day) => isSameDay(day, selectedDay),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            selectedDay = selectedDay;
            focusedDay = focusedDay;
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
