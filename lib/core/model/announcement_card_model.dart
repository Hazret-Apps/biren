import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class AnnouncementCardModel {
  final String title;
  final String description;
  final String? imagePath;
  final Timestamp createdTime;

  const AnnouncementCardModel({
    required this.title,
    required this.description,
    this.imagePath,
    required this.createdTime,
  });
}
