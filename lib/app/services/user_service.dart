import 'package:coffee_app/app/services/auth_interceptor.dart';
import 'package:coffee_app/core/values/constant.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:coffee_app/app/models/user.dart';

class UserService extends GetConnect {
  late Dio api;

  UserService() {
    api = Dio();
    api.interceptors.add(AuthInterceptor());
  }

  Future<List<User>> fetchUsers() async {
    final response = await api.get('$BASE_URL/api/users');
    if (response.statusCode == 200) {
      var userList = response.data as List;
      return userList.map((userJson) => User.fromJson(userJson)).toList();
    } else {
      throw Exception('Error fetching users data: ${response.statusCode}');
    }
  }
}