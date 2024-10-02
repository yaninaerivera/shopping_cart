import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/src/presentation/presentation.dart';

class ProductCartScreen extends StatelessWidget {
  const ProductCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return ChangeNotifierProvider.value(
      value: cart,
      child: Consumer<Cart>(
        builder: (context, cart, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Order Preview'),
            ),
            body: ListView.builder(
              itemCount: cart.items.length + 1,
              itemBuilder: (context, index) {
                if (index < cart.items.length) {
                  final product = cart.items[index];
                  return Card(
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.title),
                          Text('Price: \$${product.price.toStringAsFixed(2)}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => cart.removeItem(product),
                      ),
                    ),
                  );
                } else {
                  return ListTile(
                    title: Text('Total: \$${cart.calculateTotal()}'),
                  );
                }
              },
            ),
            bottomNavigationBar: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              onPressed: cart.calculateTotal() > 0
                  ? () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Order finished!'),
                          content: const Text('Thanks for buying!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                cart.clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductListScreen(),
                                  ),
                                );
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              child: const Text('Checkout'),
            ),
          );
        },
      ),
    );
  }
}
