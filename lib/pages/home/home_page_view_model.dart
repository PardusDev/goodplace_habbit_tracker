import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/locator.dart';
import 'package:goodplace_habbit_tracker/repository/repository.dart';

enum ViewState { geliyor, geldi, hata }

class HomePageViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewState _state = ViewState.geliyor;
  ViewState get state => _state;
  String motivasyon="";
  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }


  getMotivasyon()async{
    motivasyon = await _repository.getMotivasyon();
      notifyListeners();
  }
}