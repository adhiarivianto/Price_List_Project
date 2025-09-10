import 'package:flutter/material.dart';

class StockItemPageView extends StatefulWidget {
  const StockItemPageView({super.key});

  @override
  State<StatefulWidget> createState() => _StockItemPageViewState();
}

class _StockItemPageViewState extends State<StockItemPageView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(color: Colors.red));
  }
}
