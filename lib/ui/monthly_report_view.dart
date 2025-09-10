import 'package:flutter/material.dart';
import 'package:price_list/components/base_card.dart';

class MonthlyReportView extends StatefulWidget {
  const MonthlyReportView({super.key});

  @override
  State<StatefulWidget> createState() => _MonthlyReportViewState();
}

class _MonthlyReportViewState extends State<MonthlyReportView> {
  @override
  Widget build(BuildContext context) {
    return BaseCard(cardContent: Container());
  }
}
