import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:price_list/components/base_card.dart';
import 'package:price_list/components/stock_item_add_edit_form.dart';
import 'package:price_list/components/stock_item_data_grid_source.dart';
import 'package:price_list/constants/constants.dart';
import 'package:price_list/models/models.dart';
import 'package:price_list/storages/boxes.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockItemPageView extends StatefulWidget {
  const StockItemPageView({super.key});

  @override
  State<StatefulWidget> createState() => _StockItemPageViewState();
}

class _StockItemPageViewState extends State<StockItemPageView> {
  final DataGridController _controller = DataGridController();

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      isExpanded: false,
      cardContent: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: const Text("Left 1")),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: () {}, child: const Text("Left 2")),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 250, // desired width
                height: 34, // same as button height
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Color(ColorConstants.wildSand),
                    filled: true,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(ColorConstants.funGreen)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        SizeConstants.standardRadius,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: SizeConstants.mediumIcon,
                      color: Color(ColorConstants.funGreen),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StockItemAddEditForm();
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                    ColorConstants.wildSand,
                  ), // background color
                  foregroundColor: Color(ColorConstants.funGreen), // text color
                ),
                child: const Row(
                  children: [
                    Text('New'),
                    Icon(Icons.add, size: SizeConstants.mediumIcon),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: SizeConstants.formRegularSpacing),
          ValueListenableBuilder<Box<StockItems>>(
            valueListenable: Boxes.getStockItemBoxMethod().listenable(),
            builder: (context, box, _) {
              final listItem = box.values.toList();

              final dataSource = StockItemDataGridSource(
                data: listItem,
                context: context,
              );
              return SfDataGridTheme(
                data: SfDataGridThemeData(
                  gridLineColor: Color(ColorConstants.silverChalice),
                  gridLineStrokeWidth: 1.5,
                  selectionColor: Color(ColorConstants.lightGreen),
                  frozenPaneLineColor: Color(ColorConstants.silverChalice),
                  sortIconColor: Color(ColorConstants.black),
                  headerColor: Color(ColorConstants.paleLemon),
                  headerHoverColor: Color(ColorConstants.lightGreen),
                  rowHoverColor: Color(ColorConstants.lightGreen),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: SfDataGrid(
                    source: dataSource,
                    columns: dataSource.columns,

                    //utils
                    rowHeight: 80,
                    controller: _controller,

                    columnWidthMode:
                        ColumnWidthMode.none, // allow horizontal scrolling
                    frozenColumnsCount: 0, // nothing frozen on the left
                    footerFrozenColumnsCount: 1, //   last 1 column stays fixed

                    isScrollbarAlwaysShown: true,
                    selectionMode: SelectionMode.multiple,
                    allowSorting: true,
                    allowTriStateSorting: true,
                    onCellTap: (details) {
                      // Check if user tapped a header cell (rowIndex = 0)
                      if (details.rowColumnIndex.rowIndex == 0) {
                        // After sorting happens, schedule scroll reset
                        Future.delayed(Duration(milliseconds: 50), () {
                          _controller.scrollToVerticalOffset(0);
                        });
                      }
                    },

                    //styling
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
