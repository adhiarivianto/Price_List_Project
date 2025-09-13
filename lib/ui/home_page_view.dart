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
  final ScrollController _scrollController = ScrollController();
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
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
            child: DefaultTabController(
              length: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                        child: CustomSlidingSegmentedControl(
                          initialValue: _selectedIndex + 1,

                          children: {
                            1: Text(
                              'Stock Item',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: (_selectedIndex + 1) == 1
                                        ? const Color(ColorConstants.wildSand)
                                        : const Color(ColorConstants.tundora),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            2: Text(
                              'Monthly Report',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: (_selectedIndex + 1) == 2
                                        ? const Color(ColorConstants.wildSand)
                                        : const Color(ColorConstants.tundora),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          },
                          onValueChanged: (v) {
                            _selectedIndex = v - 1;
                            setState(() {});
                          },
                          decoration: BoxDecoration(
                            color: const Color(ColorConstants.silverChalice),
                            borderRadius: BorderRadius.circular(
                              SizeConstants.standardRadius,
                            ),
                          ),
                          innerPadding: EdgeInsets.zero,
                          fixedWidth: 200,
                          thumbDecoration: BoxDecoration(
                            color: const Color(ColorConstants.funGreen),
                            borderRadius: BorderRadius.circular(
                              SizeConstants.standardRadius,
                            ),
                            boxShadow: [
                              const BoxShadow(
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  IndexedStack(index: _selectedIndex, children: _tabPages),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> get _tabPages => [
    const Column(children: [StockItemPageView()]),
    const Column(children: [MonthlyReportView()]),
  ];
}
