import 'dart:io';

import 'package:shopping_cart/src/domain/domain.dart';
import 'package:dio/dio.dart';

class DioProductRepository implements ProductRepository {
  final dio = Dio()
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

  @override
  Future<List<Product>> getProductCurrencies() async {
    final response = await dio.get(ProductRepository.endpoint);

    if (response.statusCode == HttpStatus.ok) {
      return Product.fromDynamicList(response.data);
    } else {
      throw Exception('Failed to load product data');
    }
  }
}
