import 'package:flutter/material.dart';
import 'package:price_list/components/base_card.dart';

class StockItemPageView extends StatefulWidget {
  const StockItemPageView({super.key});

  @override
  State<StatefulWidget> createState() => _StockItemPageViewState();
}

class _StockItemPageViewState extends State<StockItemPageView> {
  @override
  Widget build(BuildContext context) {
    return BaseCard(cardContent: Container());
  }
}
