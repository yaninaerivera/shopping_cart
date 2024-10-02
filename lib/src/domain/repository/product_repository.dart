import 'package:shopping_cart/src/domain/domain.dart';

abstract class ProductRepository {
  static const endpoint = 'https://api.escuelajs.co/api/v1/products';

  Future<List<Product>> getProductCurrencies();
}
