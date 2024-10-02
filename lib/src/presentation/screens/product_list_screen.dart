import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/src/domain/domain.dart';
import 'package:shopping_cart/src/presentation/presentation.dart';
import 'package:shopping_cart/src/presentation/screens/product_cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final Products _productListState;
  @override
  void initState() {
    super.initState();
    _productListState = context.read<Products>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _productListState.getProducts();
    });
  }

  @override
  void dispose() {
    _productListState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductCartScreen(),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _productListState.getProducts(),
        child: StreamBuilder(
          stream: _productListState.productStream,
          builder: (context, snapshot) {
            late Widget result;

            if (snapshot.hasError) {
              result = Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData) {
              result = const Center(child: CircularProgressIndicator());
            } else {
              var productList = snapshot.data!;
              result = _ProductListBody(productList: productList);
            }

            return result;
          },
        ),
      ),
    );
  }
}

class _ProductListBody extends StatelessWidget {
  const _ProductListBody({required this.productList});

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];

        return ProductItem(
          product: product,
        );
      },
      separatorBuilder: (_, __) => const Divider(
        endIndent: 14.0,
        height: 2.0,
        indent: 14.0,
        thickness: 2.0,
      ),
    );
  }
}
