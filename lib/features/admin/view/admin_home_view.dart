// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:biren_kocluk/core/base/view/base_view.dart';
import 'package:biren_kocluk/features/admin/viewmodel/admin_home_viewmodel.dart';
import 'package:flutter/material.dart';

class AdminHomeView extends StatelessWidget {
  AdminHomeView({super.key});

  late final AdminHomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: viewModel,
      onPageBuilder: (context, value) => Scaffold(
        appBar: _buildAppBar,
        body: _body(),
      ),
    );
  }

  AppBar get _buildAppBar => AppBar(
        title: const Text("Yönetici"),
      );

  SafeArea _body() {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}
