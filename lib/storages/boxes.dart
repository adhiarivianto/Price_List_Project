import 'package:hive/hive.dart';
import 'package:price_list/models/models.dart';

class Boxes {
  static Box<StockItems> getStockItemBoxMethod() =>
      Hive.box<StockItems>('stockItemBox');
}
