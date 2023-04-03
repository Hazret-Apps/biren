import 'package:biren_kocluk/core/base/view/base_view.dart';
import 'package:biren_kocluk/core/enum/admin_feature_types.dart';
import 'package:biren_kocluk/core/widget/admin/admin_select_feature.dart';
import 'package:biren_kocluk/features/admin/viewmodel/admin_home_viewmodel.dart';
import 'package:flutter/material.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {
  late AdminHomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<AdminHomeViewModel>(
      onModelReady: (model) {
        model.setContext(context);
        viewModel = model;
      },
      viewModel: AdminHomeViewModel(),
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
    return SafeArea(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
        ),
        children: const [
          AdminSelectFeature(featureTypes: AdminFeatureTypes.announcement),
          AdminSelectFeature(featureTypes: AdminFeatureTypes.task),
          AdminSelectFeature(featureTypes: AdminFeatureTypes.student),
          AdminSelectFeature(featureTypes: AdminFeatureTypes.login),
          AdminSelectFeature(featureTypes: AdminFeatureTypes.study),
        ],
      ),
    );
  }
}
