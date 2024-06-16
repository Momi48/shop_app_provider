import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<CartProvider>(context).favourite;
    return Scaffold(
        
        body: favourite.isEmpty
            ? const Center(
                child: Text('No Items Are Added To Favourite '),
              )
            : ListView.builder(
                itemCount: favourite.length,
                itemBuilder: (context, index) {
                  final cartitem = favourite[index];
                  return ListTile(
                    leading: CircleAvatar(
                      foregroundImage: AssetImage(cartitem['imageUrl']),
                    ),
                    title: Text(
                      cartitem['title'],
                      style:  Theme.of(context).textTheme.headlineMedium,
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
                                  content: const Text(
                                      'Are you sure you want to delete this product from cart?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'No',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .removeFavoriteProduct(cartitem);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Yes',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red)))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )),
                  );
                }));
  }
}
