import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

import '../api_urls.dart';
import 'package:http/http.dart' as http;
import 'app_repository.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<String> logout();
  Future<String> getUserInfo(String deviceId, String appVersion, String os);
  Future<String> changePassword(
      String oldPassword, String newPassword, String confirmNewPassword);
  Future<String> getAppConfigInfo();
  Future<String> verifyDevice(String licence, String device_id);
  Future<String> loginWithClassID(String username, String classID, String licenseKey, String merchantID);
  Future<String> getListClass(String merchantID);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<String> login(String email, String password) async {
    String url = '$apiDomain$loginEP';
    if (kDebugMode) {
      print("DEBUG: step 1");
    }

    return AppRepository.init()
        .sendRequest(
          RequestMethod.post,
          url,
          false,
          body: <String, String>{'email': email, 'password': password},
        )
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
          final String jsonBody = response.body;
          return jsonBody;
        })
        // ignore: body_might_complete_normally_catch_error
        .catchError((onError) {
          if (kDebugMode) {
            print("DEBUG: error: ${onError.toString()}");
          }
        });
  }

  @override
  Future<String> getUserInfo(String deviceId, String appVersion, String os) {
    String url = '$apiDomain$getUserInfoEP';

    return AppRepository.init()
        .sendRequest(
          RequestMethod.post,
          url,
          true,
          body: <String, String>{
            'device_id': deviceId,
            'app_version': appVersion,
            'os': os
          },
        )
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
          return response.body;
        });
  }

  @override
  Future<String> logout() {
    String url = '$apiDomain$logoutEP';

    return AppRepository.init()
        .sendRequest(
          RequestMethod.post,
          url,
          true,
        )
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
      final String jsonBody = response.body;
      final int statusCode = response.statusCode;

      if (statusCode != 200 || jsonBody == null) {
        if (kDebugMode) {
          print(response.reasonPhrase);
        }
        // throw FetchDataException("StatusCode:$statusCode, Error:${response.reasonPhrase}");
      }
      return jsonBody;
    });
  }

  @override
  Future<String> changePassword(
    String oldPassword,
    String newPassword,
    String confirmNewPassword,
  ) {
    String url = '$apiDomain$changePasswordEP';

    return AppRepository.init()
        .sendRequest(
          RequestMethod.post,
          url,
          true,
          body: <String, String>{
            'password_old': oldPassword,
            'password': newPassword,
            'password_confirmation': confirmNewPassword,
          },
        )
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
          final String jsonBody = response.body;
          final int statusCode = response.statusCode;

          if (statusCode != 200 || jsonBody == null) {
            if (kDebugMode) {
              print(response.reasonPhrase);
            }
            // throw FetchDataException("StatusCode:$statusCode, Error:${response.reasonPhrase}");
          }
          return jsonBody;
        });
  }

  @override
  Future<String> getAppConfigInfo() {
    String url = '$icorrectDomain$appConfigEP';

    return AppRepository.init()
        .sendRequest(
          RequestMethod.get,
          url,
          false,
        )
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
      return response.body;
    });
  }

  @override
  Future<String> verifyDevice(String licence, String device_id) {
    String url = 'http://devapi.ielts-correction.com/$verifyLicenceEP';
    Map<String, dynamic> body = {
      'license': licence,
      'device_id': device_id
    };
    return AppRepository.init().
    sendRequest(
        RequestMethod.post,
        url, false,
        body: body
    )
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
      return response.body;
    });
  }

  @override
  Future<String> loginWithClassID(String username, String classID, String licenseKey, String merchantID) async {
    var key = utf8.encode(licenseKey);
    var bytes = utf8.encode('$classID|$merchantID|$username');
    var hmacSha256 = Hmac(sha256, key);
    var checksum = hmacSha256.convert(bytes);

    String url = 'http://devapi.ielts-correction.com/$loginClassIDEP';
    Map<String, dynamic> body = {
      'class_id': classID,
      'merchant_id': merchantID,
      'user_name': username,
      'check_sum': checksum.toString()
    };

    return AppRepository.init()
        .sendRequest(RequestMethod.post, url, false, body: body)
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
      return response.body;
    });
  }

  @override
  Future<String> getListClass(String merchantID) {
    String url = 'http://devapi.ielts-correction.com/$getListClassEP?merchant_id=$merchantID';
    return AppRepository.init()
        .sendRequest(RequestMethod.get, url, false)
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
      return response.body;
    });
  }
}
