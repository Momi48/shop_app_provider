import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/global_varaibles.dart';
import 'package:ecommerce_app/widgets/product_cart.dart';
import 'package:ecommerce_app/pages/product_details_page.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final border = const OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
      borderSide: BorderSide(
        color: Color.fromRGBO(182, 180, 180, 1),
      ));
  List<String> filters = [
    'All',
    'Nike',
    'Addidas',
    'Bata',
  ];
  int size = 0;
  List<Map<String, dynamic>> filterProducts = [];
  int count = 0;
  List<bool> toggle = [];

  void filterByCategory() {
    setState(() {
      if (filters[size] == 'All') {
        filterProducts = products;
      } else {
        filterProducts = products
            .where((product) => product['company'] == filters[size])
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    filterByCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Shop\nCollection',
                style:  Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  focusedBorder: border,
                  enabledBorder: border,
                ),
              ),
            ),
          ]),
          SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: filters.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          size = index;
                          filterByCategory();
                        });
                      },
                      child: Chip(
                        backgroundColor: size == index
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        side: const BorderSide(
                            color: Color.fromRGBO(245, 247, 249, 1)),
                        label: Text(filter,style:  Theme.of(context).textTheme.headlineSmall,),
                        labelStyle: const TextStyle(fontSize: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth > 1080) {
                return Consumer<CartProvider>(
                    builder: (context, cart, child) => GridView.builder(
                        itemCount: filterProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1.75),
                        itemBuilder: (context, index) {
                          toggle.add(false);
                          final product = filterProducts[index];
                          bool isFavorite =
                              Provider.of<CartProvider>(context, listen: false)
                                  .isFavorite(product['title']);
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ProductDetailsPage(product: product);
                              }));
                            },
                            child: ProductCart(
                              title: product['title'], //as String,
                              price: product['price'], //as double,
                              image: product['imageUrl'], //as String
                              backgroundColor: index.isEven
                                  ? const Color.fromRGBO(216, 240, 253, 1)
                                  : const Color.fromRGBO(249, 247, 245, 1),
                              icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      toggle[index] = !toggle[index];
                                      onTapFavProduct(
                                          product, index, isFavorite);
                                    });
                                  },
                                  icon: Icon(toggle[index] == true
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined)),
                            ),
                          );
                        }));
              } else {
                return Consumer<CartProvider>(
                  builder: (context, cart, child) => ListView.builder(
                      itemCount: filterProducts.length,
                      itemBuilder: (context, index) {
                        toggle.add(false);
                        final product = filterProducts[index];
                        bool isFavorite =
                            Provider.of<CartProvider>(context, listen: false)
                                .isFavorite(product['title']);
                        return GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ProductDetailsPage(product: product);
                              }));
                            },
                            child: ProductCart(
                              title: product['title'], //as String,
                              price: product['price'], //as double,
                              image: product['imageUrl'], //as String
                              backgroundColor: index.isEven
                                  ? const Color.fromRGBO(216, 240, 253, 1)
                                  : const Color.fromRGBO(249, 247, 245, 1),
                              icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      toggle[index] = !toggle[index];

                                      onTapFavProduct(
                                          product, index, isFavorite);
                                    });
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                  )),
                            ));
                      }),
                );
              }
            }),
          )
        ],
      ),
    );
  }

  void onTapFavProduct(Map<String, dynamic> fav, int index, bool isFavourite) {
    if (!isFavourite) {
      Provider.of<CartProvider>(context, listen: false).addFavoriteProduct({
        'id': fav['id'] as String,
        'title': fav['title'] as String,
        'price': fav['price'] as double,
        'imageUrl': fav['imageUrl'] as String,
        'company': fav['company'] as String
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Item Is Added To Cart'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
    } else {
      Provider.of<CartProvider>(context, listen: false)
          .removeFavoriteProduct(fav);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Item Is Removed To Cart'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }
}
