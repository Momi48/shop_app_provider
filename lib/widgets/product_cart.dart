import 'package:flutter/material.dart';

class ProductCart extends StatefulWidget {
  final String title;
  final double price;
  final String image;
  final Color backgroundColor;
  final IconButton icon;
  const ProductCart({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
    required this.icon
  });

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  Map<String, dynamic> favouriteProducts = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style:  Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 5),
          Text(
            '\$${widget.price.toString()}',
            style:  Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 5),
          Center(
            child: Image.asset(
              widget.image,
              height: 175,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.icon
            ],
          )
        ],
      ),
    );
  }
}
