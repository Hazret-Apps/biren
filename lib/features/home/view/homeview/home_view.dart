import 'package:biren_kocluk/features/home/view/announcement/announcements_view.dart';
import 'package:biren_kocluk/features/home/view/homeview/widgets/home_drawer.dart';
import 'package:biren_kocluk/features/home/view/homeview/widgets/home_select_feature_card.dart';
import 'package:biren_kocluk/features/home/view/homeworks/homeworks_view.dart';
import 'package:biren_kocluk/features/home/mixin/home_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/product/widget/card/homework_card_mini.dart';
import 'package:easy_localization/easy_localization.dart';
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
      endDrawer: const HomeViewDrawer(),
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
      title: _hiText(context),
      centerTitle: false,
    );
  }

  Card get _calendar {
    return Card(
      child: TableCalendar(
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false,
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: context.textTheme.titleMedium!.copyWith(fontSize: 12),
          weekdayStyle: context.textTheme.titleMedium!.copyWith(fontSize: 12),
        ),
        locale: AppConstants.TR_LANG,
        eventLoader: getEventsForTheDay,
        focusedDay: focusedDay,
        firstDay: firstDay,
        lastDay: lastDay,
        onPageChanged: (newFocusedDay) {
          setState(() {
            focusedDay = newFocusedDay;
          });
          loadFirestoreEvents();
        },
        selectedDayPredicate: (day) => isSameDay(day, selectedDay),
        onDaySelected: (newSelectedDay, newFocusedDay) {
          setState(() {
            selectedDay = newSelectedDay;
            focusedDay = newFocusedDay;
          });
        },
        calendarStyle: CalendarStyle(
          defaultTextStyle: context.textTheme.titleMedium!,
          outsideTextStyle: context.textTheme.titleMedium!.copyWith(
            color: LightThemeColors.grey,
          ),
          weekendTextStyle: context.textTheme.titleMedium!,
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
      style: context.textTheme.bodyMedium,
    );
  }
}
