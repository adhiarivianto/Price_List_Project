import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:price_list/constants/colors.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: SegmentedTabControl(
                        controller: _tabController,
                        tabTextColor: Color(ColorConstants.tundora),
                        textStyle: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                              color: Color(ColorConstants.wildSand),
                              fontWeight: FontWeight.bold,
                            ),
                        selectedTabTextColor: Color(ColorConstants.wildSand),
                        splashHighlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        barDecoration: const BoxDecoration(
                          color: Color(ColorConstants.silverChalice),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        indicatorDecoration: const BoxDecoration(
                          color: Color(ColorConstants.funGreen),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        tabs: _tabs,
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
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

  List<SegmentTab> get _tabs => [
    SegmentTab(label: 'Stock Item'),
    SegmentTab(label: 'Monthly Report'),
  ];

  List<Widget> get _tabPages => [StockItemPageView(), MonthlyReportView()];
}
