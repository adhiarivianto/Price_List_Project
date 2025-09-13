import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:price_list/constants/constants.dart';
import 'package:price_list/models/models.dart';
import 'package:price_list/ui/home_page_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(StockItemsAdapter());
  await Hive.openBox<StockItems>('stockItemBox');

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
        scaffoldBackgroundColor: const Color(ColorConstants.wildSand),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(ColorConstants.pastelGreen),
        ),
      ),
      home: const HomePageView(),
    );
  }
}
