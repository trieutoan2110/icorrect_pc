
import 'package:icorrect_pc/src/data_source/api_urls.dart';

import '../constants.dart';
import 'app_repository.dart';
import 'package:http/http.dart' as http;

abstract class UserAuthRepository {
  Future<String> getUserAuthDetail();
  Future<String> submitAuth(http.MultipartRequest multiRequest);
}

class UserAuthRepositoryImpl implements UserAuthRepository {
  @override
  Future<String> getUserAuthDetail() {
    String url = getUserAuthDetailEP();
    return AppRepository.init()
        .sendRequest(
          RequestMethod.get,
          url,
          true,
        )
        .timeout(const Duration(seconds: timeout))
        .then((http.Response response) {
      final String jsonBody = response.body;
      return jsonBody;
    });
  }
  
  @override
  Future<String> submitAuth(http.MultipartRequest multiRequest) async{
    return await multiRequest
        .send()
        .timeout(const Duration(seconds: timeout))
        .then((http.StreamedResponse streamResponse) async {
      if (streamResponse.statusCode == 200) {
        return await http.Response.fromStream(streamResponse)
            .timeout(const Duration(seconds: timeout))
            .then((http.Response response) {
          final String jsonBody = response.body;
          return jsonBody;
        }).catchError((onError) {
          return '';
        });
      } else {
        return '';
      }
    }).catchError((onError) {
      return '';
    });
  }
}
