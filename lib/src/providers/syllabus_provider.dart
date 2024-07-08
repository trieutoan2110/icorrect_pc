import 'package:flutter/cupertino.dart';
import 'package:icorrect_pc/src/models/homework_models/syllabusDB_model.dart';

import '../models/homework_models/syllabus_merchant_model.dart';

class SyllabusProvider extends ChangeNotifier {
  bool isDisposed = false;

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  @override
  void notifyListeners() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  List<Syllabus> _listSyllabus = [];
  List<Syllabus> get listSyllabus => _listSyllabus;

  void setListSyllabus(List<Syllabus> list) {
    _listSyllabus.clear();
    _listSyllabus.addAll(list);
    if (!isDisposed) {
      notifyListeners();
    }
  }

  List<SyllabusDBModel> _listSyllabusDB = [];
  List<SyllabusDBModel> get listSyllabusDB => _listSyllabusDB;

  void setListSyllabusDB(List<SyllabusDBModel> list) {
    _listSyllabusDB.clear();
    _listSyllabusDB.addAll(list);
    if (!isDisposed) {
      notifyListeners();
    }
  }

  int _total = 0;
  int get total => _total;

  void setTotal(int total) {
    _total = total;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  bool _isDownloadProgressing = false;
  bool get isDownloadProgressing => _isDownloadProgressing;
  void setStatusDownloadProgressing(bool status) {
    _isDownloadProgressing = status;
    if (!isDisposed) {
      notifyListeners();
    }
  }
}