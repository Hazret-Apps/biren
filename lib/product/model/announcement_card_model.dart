import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class AnnouncementModel {
  final String title;
  final String description;
  final String? imagePath;
  final Timestamp createdTime;

  const AnnouncementModel({
    required this.title,
    required this.description,
    this.imagePath,
    required this.createdTime,
  });
}
