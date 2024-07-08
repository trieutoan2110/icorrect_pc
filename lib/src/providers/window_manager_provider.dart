import 'package:flutter/cupertino.dart';

class WindowManagerProvider extends ChangeNotifier {
  bool _isShowExitApp = false;
  bool get isShowExitApp => _isShowExitApp;

  void setShowExitApp(bool show) {
    _isShowExitApp = show;
    notifyListeners();
  }

  bool _isShowExitAppDoingTest = false;
  bool get isShowExitAppDoingTest => _isShowExitAppDoingTest;

  void setShowExitAppDoingTest(bool show) {
    _isShowExitAppDoingTest = show;
    notifyListeners();
  }
}