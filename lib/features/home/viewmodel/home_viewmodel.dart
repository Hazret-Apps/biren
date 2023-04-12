import 'package:mobx/mobx.dart';

part 'home_viewmodel.g.dart';

class HomeViewModel = HomeViewModelBase with _$HomeViewModel;

abstract class HomeViewModelBase with Store {}
