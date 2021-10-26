import 'dart:developer';

import 'package:flutter/widgets.dart';

import '../enums/viewstate.dart';

class BaseProvider<T> extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ViewState get state => _state;
  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  get isBusy => _state == ViewState.busy;

  List<T> dataList = [];
  final int nextPageThreshold = 5;
  int page = 0;
  bool isMoreAvailable = true;

  Future loadinfinityData({required Future<List<T>> Function(int page) loadData}) async {
    log('///////////////////////////////  loadinfinityData  $page');
    try {
      setState(ViewState.busy);
      if (page == 0) dataList.clear();

      var list = await loadData(++page);
      log(list.toString());
      dataList.insertAll(dataList.length, list);

      if (list.isEmpty) isMoreAvailable = false;

      setState(ViewState.idle);
    } catch (error) {
      setState(ViewState.idle);
      rethrow;
    }
  }

  void resetSetting() {
    page = 0;
    isMoreAvailable = true;
    dataList.clear();
  }

  Future loadData({required Function() loadData}) async {
    try {
      setState(ViewState.busy);
      await loadData();
      setState(ViewState.idle);
    } catch (error) {
      setState(ViewState.idle);
      rethrow;
    }
  }
}
