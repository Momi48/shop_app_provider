import 'package:ecommerce_app/pages/cart_page.dart';
import 'package:ecommerce_app/pages/favourite_page.dart';
import 'package:ecommerce_app/provider/theme_provider.dart';
import 'package:ecommerce_app/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  bool isOne = false;
  List<Widget> pages = const [ProductList(), CartPage(), FavouritePage()];

  @override
  Widget build(BuildContext context) {
    var themeValue = Provider.of<ThemeChanger>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  
                });
                isOne = !isOne;
                print('Bool here is $isOne');
                themeValue.setTheme(isOne);
              },
              icon: Icon(isOne == true  ? Icons.dark_mode : Icons.light_mode)),
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
          iconSize: 30,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: '',
            ),
          ]),
    );
  }
}
