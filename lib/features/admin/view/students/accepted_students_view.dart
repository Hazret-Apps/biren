import 'package:biren_kocluk/features/admin/view/students/mixin/accepted_students_operation_mixin.dart';
import 'package:biren_kocluk/product/init/lang/locale_keys.g.dart';
import 'package:biren_kocluk/product/init/theme/light_theme_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AcceptedStudentsView extends StatefulWidget {
  const AcceptedStudentsView({super.key});

  @override
  State<AcceptedStudentsView> createState() => _AcceptedStudentsViewState();
}

class _AcceptedStudentsViewState extends State<AcceptedStudentsView>
    with AcceptedStudentsOperationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.features_registeredStudents.tr()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: _userName(snapshot, index),
                  leading: _avatar(snapshot, index),
                  trailing: IconButton(
                    onPressed: () {
                      callStudentEditView(context, snapshot, index);
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Text _userName(AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) =>
      Text(name(snapshot, index));

  CircleAvatar _avatar(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return CircleAvatar(
      backgroundColor: LightThemeColors.blazeOrange.withOpacity(.3),
      child: Text(
        name(snapshot, index).characters.first,
      ),
    );
  }
}
