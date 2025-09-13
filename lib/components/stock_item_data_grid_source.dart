import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:price_list/constants/constants.dart';
import 'package:price_list/models/models.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockItemDataGridSource extends DataGridSource {
  final BuildContext context;

  StockItemDataGridSource({
    required List<StockItems> data,
    required this.context,
  }) {
    _stockItemData = data
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<Uint8List?>(
                columnName: 'productImage',
                value: e.productImage,
              ),

              DataGridCell<String>(
                columnName: 'productName',
                value: e.productName,
              ),

              DataGridCell<int>(columnName: 'stockItem', value: e.stockItem),

              DataGridCell<double>(
                columnName: 'marketPrice',
                value: e.marketPrice,
              ),

              DataGridCell<double>(
                columnName: 'profitMargin',
                value: e.profitMargin,
              ),

              DataGridCell<double>(
                columnName: 'sellingPrice',
                value:
                    (e.marketPrice + (e.marketPrice * (e.profitMargin / 100))),
              ),

              DataGridCell<double>(
                columnName: 'profitPerItem',
                value: (e.marketPrice * (e.profitMargin / 100)),
              ),

              DataGridCell(columnName: 'actions', value: null),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _stockItemData = [];

  @override
  List<DataGridRow> get rows => _stockItemData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      color: Color(ColorConstants.wildSand),
      cells: [
        // productImage
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: (row.getCells()[0].value != null)
              ? InkWell(
                  onTap: () {},
                  child: Image.memory(
                    row.getCells()[0].value as Uint8List,
                    fit: BoxFit.fill,
                  ),
                )
              : const Icon(
                  Icons.image_not_supported,
                  color: Color(ColorConstants.stacks),
                ),
        ),

        // productName
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(
            row.getCells()[1].value.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(ColorConstants.black),
            ),
          ),
        ),

        // stockItem
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(
            toCurrencyString(
              row.getCells()[2].value.toString(),
              mantissaLength: 0,
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(ColorConstants.black),
            ),
          ),
        ),

        // marketPrice
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(
            toCurrencyString(row.getCells()[3].value.toString()),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(ColorConstants.black),
            ),
          ),
        ),

        // profitMargin
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(
            "${toCurrencyString(row.getCells()[4].value.toString())}%",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(ColorConstants.black),
            ),
          ),
        ),

        // profitMargin
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(
            toCurrencyString(row.getCells()[5].value.toString()),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(ColorConstants.black),
            ),
          ),
        ),

        // profitMargin
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(
            toCurrencyString(row.getCells()[6].value.toString()),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Color(ColorConstants.black),
            ),
          ),
        ),

        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text("Action Here"),
        ),
      ],
    );
  }

  List<GridColumn> get columns => [
    GridColumn(
      columnName: 'productImage',
      width: 150,
      allowSorting: false,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Product\nImage',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'productName',
      width: MediaQuery.of(context).size.width * 0.20,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Product Name',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'stockItem',
      width: 110,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Stock\nItem',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'marketPrice',
      width: MediaQuery.of(context).size.width * 0.13,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Market Price',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'profitMargin',
      width: 110,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Profit\nMargin',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'sellingPrice',
      width: MediaQuery.of(context).size.width * 0.13,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Selling Price',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'profitPerItem',
      width: MediaQuery.of(context).size.width * 0.11,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Profit per\nItem',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'actions',
      allowSorting: false,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ];
}
