import 'dart:convert';
import 'package:coffee_app/app/models/product.dart';
import 'package:coffee_app/app/services/auth_interceptor.dart';
import 'package:coffee_app/core/values/constant.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ProductService {
  late Dio api;

  ProductService() {
    api = Dio();
    api.interceptors.add(AuthInterceptor());
  }

  Future<List<Product>> fetchProducts() async {
    final response = await api.get('$BASE_URL/api/products');
    if (response.statusCode == 200) {
      var productList = response.data as List;
    
      List<Product> users =
          productList.map((userJson) => Product.fromJson(userJson)).toList();
      return users;
    } else {
      throw Exception('No users data found in the response');
    }
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final response = await api.get('$BASE_URL/api/products/category/$categoryId');
    print("response fetching api: $response");
    if (response.statusCode == 200) {
      var productList = response.data as List;
    
      List<Product> users =
          productList.map((userJson) => Product.fromJson(userJson)).toList();
      return users;
    } else {
      throw Exception('No users data found in the response');
    }
  }

}
