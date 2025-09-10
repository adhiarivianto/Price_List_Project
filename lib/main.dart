import 'package:flutter/material.dart';
import 'package:price_list/constants/colors.dart';
import 'package:price_list/home_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Price Listing App',

      theme: ThemeData(
        scaffoldBackgroundColor: Color(ColorConstants.wildSand),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(ColorConstants.pastelGreen),
        ),
      ),
      home: const HomePageView(),
    );
  }
}
