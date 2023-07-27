import 'package:biren_kocluk/features/home/view/homeview/widgets/home_drawer.dart';
import 'package:biren_kocluk/features/home/mixin/home_operation_mixin.dart';
import 'package:biren_kocluk/product/constants/app_constants.dart';
import 'package:biren_kocluk/product/enum/firebase_collection_enum.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:biren_kocluk/features/auth/service/auth_service.dart';
import 'package:biren_kocluk/product/widget/card/homework_card_mini.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

class _HomeViewState extends State<HomeView> with HomeOperationMixin {
  late Stream<QuerySnapshot> stream;
  int currentSlideIndex = 0;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    stream = FirebaseCollections.showcase.reference.snapshots();
  }

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
      child: SingleChildScrollView(
        child: Column(
          children: [
            context.emptySizedHeightBoxLow,
            SizedBox(
              height: context.height / 5,
              width: double.infinity,
              child: StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index, realIndex) {
                        DocumentSnapshot sliderData =
                            snapshot.data!.docs[index];
                        return Image.network(
                          sliderData["image"],
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                },
              ),
            ),
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
