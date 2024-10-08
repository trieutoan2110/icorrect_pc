import 'package:flutter/foundation.dart';
import 'package:icorrect_pc/src/data_source/constants.dart';
import 'package:icorrect_pc/src/models/homework_models/new_api_135/activities_model.dart';
import 'package:icorrect_pc/src/models/homework_models/new_api_135/new_class_model.dart';
import 'package:icorrect_pc/src/utils/utils.dart';

import '../models/user_data_models/user_data_model.dart';
import '../presenters/simulator_test_presenter.dart';

class HomeProvider extends ChangeNotifier {
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

  void clearData() {
    _activitiesFilter = [];
    _activitiesList = [];
    _classesList = [];
    _classSelected = NewClassModel();
    _statusActivity = Utils.instance().multiLanguage(StringConstants.all);
    if (!isDisposed) {
      notifyListeners();
    }
  }

  String _currentTime = "";
  String get currentTime => _currentTime;
  void setCurrentTime(String time) {
    _currentTime = time;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  List<String> _statusSelections = [
    Utils.instance().multiLanguage(StringConstants.all),
    Utils.instance().multiLanguage(StringConstants.submitted),
    Utils.instance().multiLanguage(StringConstants.corrected),
    Utils.instance().multiLanguage(StringConstants.not_completed),
    Utils.instance().multiLanguage(StringConstants.late_title),
    Utils.instance().multiLanguage(StringConstants.out_of_date)
  ];

  List<String> get statusSelections => _statusSelections;
  void setStatusSelections(List<String> selections) {
    _statusSelections = selections;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  List<ActivitiesModel> _activitiesList = [];
  List<ActivitiesModel> get activitiesList => _activitiesList;

  void setActivitiesList(List<ActivitiesModel> list) {
    _activitiesList = list;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  List<ActivitiesModel> _activitiesFilter = [];
  List<ActivitiesModel> get activitiesFilter => _activitiesFilter;

  void setActivitiesFilter(List<ActivitiesModel> list) {
    _activitiesFilter = list;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  List<NewClassModel> _classesList = [];
  List<NewClassModel> get classesList => _classesList;

  void setClassesList(List<NewClassModel> classesList) {
    _classesList = classesList;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  NewClassModel _classSelected = NewClassModel();
  NewClassModel get classSelected => _classSelected;

  void setClassSelection(NewClassModel classModel) {
    _classSelected = classModel;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  String _statusActivity = Utils.instance().multiLanguage(StringConstants.all) ;
  String get statusActivity => _statusActivity;

  void setStatusActivity(String status) {
    _statusActivity = status;
    if (!isDisposed) {
      notifyListeners();
    }
  }

  //Current user information
  UserDataModel _currentUser = UserDataModel();
  UserDataModel get currentUser => _currentUser;
  void setCurrentUser(UserDataModel user) {
    _currentUser = user;

    if (!isDisposed) {
      notifyListeners();
    }
  }

  SimulatorTestPresenter? _simulatorTestPresenter;
  SimulatorTestPresenter? get simulatorTestPresenter => _simulatorTestPresenter;
  void setSimulatorTestPresenter(SimulatorTestPresenter? presenter) {
    _simulatorTestPresenter = presenter;
  }
}
