import 'package:biren_kocluk/core/base/model/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'admin_home_viewmodel.g.dart';

class AdminHomeViewModel = _AdminHomeViewModelBase with _$AdminHomeViewModel;

abstract class _AdminHomeViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @override
  void init() {}
}
