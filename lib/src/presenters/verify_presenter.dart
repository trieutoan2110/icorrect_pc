import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:icorrect_pc/src/data_source/dependency_injection.dart';
import 'package:icorrect_pc/src/data_source/repositories/auth_repository.dart';
import 'package:icorrect_pc/src/models/auth_models/class_merchant_model.dart';
import 'package:icorrect_pc/src/models/auth_models/verify_model.dart';
import 'package:icorrect_pc/src/models/log_models/log_model.dart';

import '../data_source/constants.dart';
import '../data_source/local/app_shared_preferences_keys.dart';
import '../data_source/local/app_shared_references.dart';
import '../utils/utils.dart';

abstract class VerifyViewContact {
  void onVerifyComplete(String merchantID);
  void onVerifyError(String message);
  void onGetListClassComplete(List<Datum> list);
  void onGetListClassError(String message);
}

class VerifyPresenter {
  final VerifyViewContact? _view;
  AuthRepository? _repository;
  VerifyPresenter(this._view) {
    _repository = Injector().getAuthRepository();
  }

  Future verify(BuildContext context, String licenseKey) async {
    assert(_view != null && _repository != null);

    LogModel? log;
    if (context.mounted) {
      log = await Utils.instance()
          .prepareToCreateLog(context, action: LogEvent.callApiVerify);
    }
    String deviceID = await Utils.instance().getDeviceIdentifier();

    _repository!.verifyDevice(licenseKey, deviceID).then((value) async {
      VerifyModel verifyModel = VerifyModel.fromJson(jsonDecode(value));
      if (verifyModel.errorCode == 200) {
        Utils.instance().prepareLogData(
            log: log,
            data: jsonDecode(value),
            message: verifyModel.messages,
            status: LogEvent.success
        );
        await _saveMerchainID(verifyModel.data!.merchantId);
        await _saveLicenseKey(licenseKey);
        _view!.onVerifyComplete(verifyModel.data!.merchantId);
      } else if (verifyModel.errorCode == 401) {
        Utils.instance().prepareLogData(
            log: log,
            data: jsonDecode(value),
            message: verifyModel.messages,
            status: LogEvent.failed
        );
        _view!.onVerifyError(verifyModel.messages!);
      } else {
        Utils.instance().prepareLogData(
            log: log,
            data: jsonDecode(value),
            message: StringConstants.network_error_message,
            status: LogEvent.failed
        );
        _view!.onVerifyError(verifyModel.messages!);
      }
    });
  }

  Future _saveLicenseKey(String key) async {
    AppSharedPref.instance()
        .putString(key: AppSharedKeys.licenseKey, value: key);
  }

  Future _saveMerchainID(String merchantID)  async {
    AppSharedPref.instance()
        .putString(key: AppSharedKeys.merchantID, value: merchantID);
  }

  void getListClass(BuildContext context, String merchantID) async {
    assert(_view != null && _repository != null);
    LogModel? log;
    if (context.mounted) {
      log = await Utils.instance()
          .prepareToCreateLog(context, action: LogEvent.callApiGetListClass);
    }
    _repository!.getListClass(merchantID).then((value) {
      ClassMerchantModel classMerchantModel = ClassMerchantModel.fromJson(jsonDecode(value));
      if (classMerchantModel.errorCode == 200) {
        List<Datum> classes = classMerchantModel.data!.data;
        Utils.instance().prepareLogData(
            log: log,
            data: jsonDecode(value),
            message: classMerchantModel.messages,
            status: LogEvent.success
        );
        _view!.onGetListClassComplete(classes);
      } else {
        if (classMerchantModel.messages!.isNotEmpty) {
          Utils.instance().prepareLogData(
              log: log,
              data: jsonDecode(value),
              message: classMerchantModel.messages,
              status: LogEvent.success
          );
        } else {
          Utils.instance().prepareLogData(
              log: log,
              data: jsonDecode(value),
              message: StringConstants.network_error_message,
              status: LogEvent.success
          );
        }
        _view!.onGetListClassError(classMerchantModel.messages!);
      }
    });
  }
}