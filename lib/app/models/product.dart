import 'dart:convert';

import 'package:coffee_app/app/models/category.dart';

class Product {
  final int id;
  final String uuid;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final bool status;
  final String name;
  final String description;
  final String price;
  final int stockQty;
  final String thumbnail;
  final int categoryId;
  final double? discount;
  final Category category; // Include category here

  // Constructor
  Product({
    required this.id,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.status,
    required this.name,
    required this.description,
    required this.price,
    required this.stockQty,
    required this.thumbnail,
    required this.categoryId,
    this.discount,
    required this.category, // Add category to constructor
  });

  // Factory method to create a Product object from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      uuid: json['uuid'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'], // deletedAt can be null
      status: json['status'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stockQty: json['stockQty'],
      thumbnail: json['thumbnail'],
      categoryId: json['categoryId'],
      discount: json['discount'],
      category: Category.fromJson(json['category']), // Parse category
    );
  }

  // Method to convert a Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'status': status,
      'name': name,
      'description': description,
      'price': price,
      'stockQty': stockQty,
      'thumbnail': thumbnail,
      'categoryId': categoryId,
      'discount': discount,
      'category': category.toJson(), 
    };
  }
}
