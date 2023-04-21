import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.querySnapshot});
  final AsyncSnapshot<QuerySnapshot<Object?>> querySnapshot;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: querySnapshot.data!.docs.length,
      options: CarouselOptions(
        height: 175,
        autoPlay: true,
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          margin: context.paddingLow,
          width: context.width,
          decoration: BoxDecoration(
            color: LightThemeColors.snowbank,
            borderRadius: context.normalBorderRadius,
            image: querySnapshot.data!.docs[index]["imagePath"] == null
                ? null
                : DecorationImage(
                    image: NetworkImage(
                      querySnapshot.data!.docs[index]["imagePath"],
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Padding(
            padding: context.paddingLow,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      querySnapshot.data!.docs[index]["title"],
                      style: context.textTheme.titleLarge?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      querySnapshot.data!.docs[index]["description"],
                      style: context.textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
