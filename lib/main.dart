import 'package:flutter/material.dart';
import 'package:shopping_cart/src/data/data.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:shopping_cart/src/presentation/presentation.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider<Products>.value(
          value: Products(productRepository: HttpProductRepository()),
        ),
        ChangeNotifierProvider<Cart>(
          create: (context) => Cart(),
        ),
      ],
      child: const ShoppingCartApp(),
    ),
  );
}

class ShoppingCartApp extends StatelessWidget {
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProductListScreen(),
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
    );
  }
}
