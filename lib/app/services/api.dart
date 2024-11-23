import 'package:coffee_app/core/values/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Api {
  Dio api = Dio();
  String? accessToken;

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Api() {
    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        accessToken = await getToken();
        print("Access token in onRequest: $accessToken");
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      },
      onError: (error, handler) async {
        print("Error occurred: ${error.response?.statusCode}");
        if (error.response?.statusCode == 401) {
          if (await _storage.containsKey(key: 'refresh')) {
            await refreshToken();
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'access');
  }

  Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refresh');
    print("Refreshing token with refresh token: $refreshToken");

    final response = await api.post('$BASE_URL/api/auth/refresh', data: {
      'refresh': refreshToken,
    });

    if (response.statusCode == 200) {
      accessToken = response.data['access'];
      await _storage.write(key: 'access', value: accessToken);
      await _storage.write(key: 'refresh', value: response.data['refresh']);
      print("New access token: $accessToken");
    } else if(response.statusCode == 403){
      print("forbiden ...");
    }else {
      accessToken = null;
      await _storage.deleteAll();
      print("Failed to refresh token, clearing storage");
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}