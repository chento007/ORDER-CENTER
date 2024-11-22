import 'package:coffee_app/app/models/category.dart';
import 'package:coffee_app/app/services/auth_interceptor.dart';
import 'package:coffee_app/core/values/constant.dart';
import 'package:dio/dio.dart';

class CategoryService {
  late Dio api;

  CategoryService() {
    api = Dio();
    api.interceptors.add(AuthInterceptor());
  }

  Future<List<Category>> fetchCategories() async {
    final response = await api.get('$BASE_URL/api/categories');
    if (response.statusCode == 200) {
      var productList = response.data as List;

      List<Category> categories=
          productList.map((category) => Category.fromJson(category)).toList();
      return categories;
    } else {
      throw Exception('No users data found in the response');
    }
  }
}
