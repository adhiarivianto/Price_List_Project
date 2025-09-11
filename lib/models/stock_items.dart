import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'stock_items.g.dart'; // this will be generated

@HiveType(typeId: 0) // unique id for this class
class StockItems {
  @HiveField(0)
  String productId;

  @HiveField(1)
  Uint8List? productImage;

  @HiveField(2)
  String productName;

  @HiveField(3)
  double marketPrice;

  @HiveField(4)
  double profitMargin;

  @HiveField(5)
  int stockItem;

  StockItems({
    required this.productId,
    this.productImage,
    required this.productName,
    required this.marketPrice,
    required this.profitMargin,
    this.stockItem = 0,
  });
}
