import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/pages/home_page.dart';
import 'package:ecommerce_app/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final latoText = TextTheme(
    headlineLarge: GoogleFonts.lato(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
    headlineSmall: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ThemeChanger()),
      ],
      child: Builder(builder: (BuildContext context) {
        final themeValue = Provider.of<ThemeChanger>(context).currentTheme;
        return MaterialApp(
          themeMode: themeValue,
          theme: ThemeData(
            brightness: Brightness.light,
            textTheme: latoText,
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(254, 206, 1, 1),
              primary: const Color.fromRGBO(254, 206, 1, 1),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(fontWeight: FontWeight.bold),
              prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            textTheme: latoText,
               
          ),
          home: const HomePage(),
        );
      }),
    );
  }
}
