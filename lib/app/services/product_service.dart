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

  // Fetch products with pagination
  // Fetch products with pagination
  Future<List<Product>> fetchProducts(
      int page, int pageSize, String search) async {
    final response = await api.get(
      '$BASE_URL/api/products',
      queryParameters: {'page': page, 'pageSize': pageSize, 'search': search},
    );

    if (response.statusCode == 200) {
      var productList = response.data as List;
      List<Product> products = productList
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      return products;
    } else {
      throw Exception('Error fetching products');
    }
  }

  Future<List<Product>> fetchProductsByCategory(int categoryId) async {
    final response =
        await api.get('$BASE_URL/api/products/category/$categoryId');
    if (response.statusCode == 200) {
      var productList = response.data as List;

      List<Product> users =
          productList.map((userJson) => Product.fromJson(userJson)).toList();
      return users;
    } else {
      throw Exception('No users data found in the response');
    }
  }

  Future<bool> updateStatus(int id) async {
    try {

      final response = await api.put('$BASE_URL/api/products/status/$id');

      print("response created: $response");
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('update status fail');
      }
    } catch (e) {
      print("error: $e");
    }
    return false;
  }

    Future<bool> updatePopular(int id) async {
    try {

      final response = await api.put('$BASE_URL/api/products/popular/$id');

      print("response created: $response");
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('update status fail');
      }
    } catch (e) {
      print("error: $e");
    }
    return false;
  }

    Future<bool> deleteById(int id) async {
    try {

      final response = await api.delete('$BASE_URL/api/products/$id');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('delete product fail');
      }
    } catch (e) {
      print("error: $e");
    }
    return false;
  }

  Future<bool> insertProduct(
    String name,
    String description,
    double price,
    int stockQty,
    int categoryId,
    double discount,
  ) async {
    var data = json.encode({
      "name": name,
      "description": description,
      "price": price,
      "stockQty": stockQty,
      "categoryId": categoryId,
      "discount": discount
    });

    final response = await api.post('$BASE_URL/api/products', data: data);
    print("response created: $response");
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('No users data found in the response');
    }
  }
}
