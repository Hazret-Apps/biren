import 'package:biren_kocluk/product/constants/firestore_field_constants.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExamDetailView extends StatefulWidget {
  const ExamDetailView(
      {super.key, required this.snapshot, required this.index});

  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;

  @override
  State<ExamDetailView> createState() => _ExamDetailViewState();
}

class _ExamDetailViewState extends State<ExamDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                widget.snapshot.data?.docs[widget.index]
                            [FirestoreFieldConstants.fileTypeField] ==
                        FirestoreFieldConstants.fileField
                    ? SizedBox(
                        height: context.height / 1.5,
                        child: SfPdfViewer.network(
                          widget.snapshot.data?.docs[widget.index]
                              [FirestoreFieldConstants.fileField],
                        ),
                      )
                    : Image.network(
                        widget.snapshot.data?.docs[widget.index]
                            [FirestoreFieldConstants.fileField],
                      ),
                context.emptySizedHeightBoxLow3x,
                Padding(
                  padding: context.horizontalPaddingNormal,
                  child: Text(
                    widget.snapshot.data?.docs[widget.index]
                                [FirestoreFieldConstants.descriptionField] ==
                            ""
                        ? LocaleKeys.noDescription.tr()
                        : widget.snapshot.data?.docs[widget.index]
                            [FirestoreFieldConstants.descriptionField],
                    style: context.textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        widget.snapshot.data?.docs[widget.index]
                    [FirestoreFieldConstants.titleField] ==
                ""
            ? LocaleKeys.noTitle.tr()
            : widget.snapshot.data?.docs[widget.index]
                [FirestoreFieldConstants.titleField],
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
