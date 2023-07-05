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
                widget.snapshot.data?.docs[widget.index]["fileType"] == "file"
                    ? SizedBox(
                        height: context.height / 1.5,
                        child: SfPdfViewer.network(
                          widget.snapshot.data?.docs[widget.index]["file"],
                        ),
                      )
                    : Image.network(
                        widget.snapshot.data?.docs[widget.index]["file"],
                      ),
                context.emptySizedHeightBoxLow3x,
                Padding(
                  padding: context.horizontalPaddingNormal,
                  child: Text(
                    widget.snapshot.data?.docs[widget.index]["description"] ==
                            ""
                        ? LocaleKeys.noDescription.tr()
                        : widget.snapshot.data?.docs[widget.index]
                            ["description"],
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
        widget.snapshot.data?.docs[widget.index]["title"] == ""
            ? LocaleKeys.noTitle.tr()
            : widget.snapshot.data?.docs[widget.index]["title"],
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
