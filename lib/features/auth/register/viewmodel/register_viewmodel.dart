// ignore_for_file: library_private_types_in_public_api

import 'package:biren_kocluk/core/base/model/base_view_model.dart';
import 'package:biren_kocluk/features/auth/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'register_viewmodel.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callLoginView() {
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => LoginView(),
      ),
      (route) => false,
    );
  }
}