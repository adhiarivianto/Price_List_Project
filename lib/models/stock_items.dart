import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'stock_items.g.dart'; // this will be generated

@HiveType(typeId: 0) // unique id for this class
class StockItems {
  @HiveField(0)
  Uint8List? productImage;

  @HiveField(1)
  String productName;

  @HiveField(2)
  double marketPrice;

  @HiveField(3)
  double profitMargin;

  StockItems({
    this.productImage,
    required this.productName,
    required this.marketPrice,
    required this.profitMargin,
  });
}
