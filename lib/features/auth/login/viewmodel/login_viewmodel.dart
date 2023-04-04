// ignore_for_file: library_private_types_in_public_api

import 'package:biren_kocluk/core/base/model/base_view_model.dart';
import 'package:biren_kocluk/features/admin/view/admin_home_view.dart';
import 'package:biren_kocluk/features/auth/register/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'login_viewmodel.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}

  @action
  void callRegisterView() {
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => const RegisterView(),
      ),
      (route) => false,
    );
  }

  @action
  void callAdminHomeView() {
    Navigator.pushAndRemoveUntil(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => const AdminHomeView(),
      ),
      (route) => false,
    );
  }
}
