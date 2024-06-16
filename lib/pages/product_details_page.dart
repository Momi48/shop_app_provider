import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int size = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            widget.product['title'] as String,
            style:  Theme.of(context).textTheme.headlineLarge,
          ),
          const Spacer(),
          Image.asset(
            widget.product['imageUrl'],
            height: 200,
          ),
          const Spacer(
            flex: 2,
          ),
          Container(
            height: 250,
            width: double.infinity,
            color: const Color.fromRGBO(245, 247, 249, 1),
            child: Column(
              children: [
                Text(
                  '\$${widget.product['price'].toString()}',
                  style:  Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes'] as List<int>).length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                size = widget.product['sizes'][index];
                              });
                            },
                            child: Chip(
                                label: Text(
                                    widget.product['sizes'][index].toString()),
                                backgroundColor:
                                    size == widget.product['sizes'][index]
                                        ? Theme.of(context).colorScheme.primary
                                        : null),
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart),
                        Text('Add To Cart', style:  Theme.of(context).textTheme.headlineMedium),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void onTap() {
    if (size != 0) {
      Provider.of<CartProvider>(context, listen: false).addCartProducts({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'company': widget.product['company'],
        'size': size,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Item Is Added To Cart'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Select A Size'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ));
    }
  }
}
