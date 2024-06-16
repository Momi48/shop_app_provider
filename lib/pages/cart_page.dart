import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
        
        body: cart.isEmpty ? const Center(child: Text('No Items Are Added to Cart'),) : ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              final cartitem = cart[index];
              return ListTile(
                leading: CircleAvatar(
                  foregroundImage: AssetImage(cartitem['imageUrl'] as String),
                ),
                title: Text(
                  cartitem['title'] as String,
                  style:  Theme.of(context).textTheme.headlineMedium,
                ),
                subtitle: Text(
                  'Size: ${cartitem['size'] as int}',
                  style:  Theme.of(context).textTheme.headlineSmall,
                ),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Delete Product',
                                style:  Theme.of(context).textTheme.headlineMedium,
                              ),
                              content: const Text('Are you sure you want to delete this product from cart?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'No',
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Provider.of<CartProvider>(context,listen: false)
                                          .removeCartProducts(cartitem);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      'Yes',
                                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red)
                                      
                                    )
                                    )
                              ],
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              );
            }));
  }
}
