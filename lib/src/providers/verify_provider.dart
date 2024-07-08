import 'package:flutter/cupertino.dart';
import 'package:icorrect_pc/src/models/auth_models/class_merchant_model.dart';

class VerifyProvider extends ChangeNotifier {
  List<Datum> _listClass = [];
  List<Datum> get listClass => _listClass;

  void setListClass(List<Datum> classes) {
    _listClass.addAll(classes);
    // notifyListeners();
  }

  void resetListClass() {
    _listClass.clear();
  }
}