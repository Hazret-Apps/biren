import 'package:biren_kocluk/features/home/mixin/exams_home_operation_mixin.dart';
import 'package:biren_kocluk/features/home/view/exams/widget/exam_widget.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExamsView extends StatefulWidget {
  const ExamsView({super.key});

  @override
  State<ExamsView> createState() => _ExamsViewState();
}

class _ExamsViewState extends State<ExamsView> with ExamsHomeOperationMixin {
  PdfViewerController? pdfViewerController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.features_exams.tr())),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: context.horizontalPaddingNormal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return ExamWidget(snapshot, index);
                },
              );
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }
}
