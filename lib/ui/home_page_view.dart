import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:price_list/constants/constants.dart';
import 'package:price_list/ui/monthly_report_view.dart';
import 'package:price_list/ui/stock_item_page_view.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(ColorConstants.funGreen),
        title: Text(
          'Price Listing App',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Color(ColorConstants.wildSand),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: DefaultTabController(
            length: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSlidingSegmentedControl(
                      initialValue: _selectedIndex + 1,
                      children: {
                        1: Text(
                          'Stock Item',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: (_selectedIndex + 1) == 1
                                    ? Color(ColorConstants.wildSand)
                                    : Color(ColorConstants.tundora),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        2: Text(
                          'Monthly Report',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: (_selectedIndex + 1) == 2
                                    ? Color(ColorConstants.wildSand)
                                    : Color(ColorConstants.tundora),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      },
                      onValueChanged: (v) {
                        _selectedIndex = v - 1;
                        setState(() {});
                      },
                      decoration: BoxDecoration(
                        color: Color(ColorConstants.silverChalice),
                        borderRadius: BorderRadius.circular(
                          SizeConstants.standardRadius,
                        ),
                      ),
                      innerPadding: EdgeInsets.zero,
                      fixedWidth: 200,
                      thumbDecoration: BoxDecoration(
                        color: Color(ColorConstants.funGreen),
                        borderRadius: BorderRadius.circular(
                          SizeConstants.standardRadius,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _tabPages,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get _tabPages => [
    Column(children: [StockItemPageView()]),
    Column(children: [MonthlyReportView()]),
  ];
}
