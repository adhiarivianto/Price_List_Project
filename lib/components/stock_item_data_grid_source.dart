import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:price_list/constants/constants.dart';
import 'package:price_list/models/models.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StockItemDataGridSource extends DataGridSource {
  StockItemDataGridSource({required List<StockItems> data}) {
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
              : const Icon(Icons.image_not_supported, color: Colors.grey),
        ),

        // productName
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(row.getCells()[1].value.toString()),
        ),

        // stockItem
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(row.getCells()[2].value.toString()),
        ),

        // marketPrice
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text(row.getCells()[3].value.toString()),
        ),

        // profitMargin
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text("${row.getCells()[4].value}%"),
        ),

        // profitMargin
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text("${row.getCells()[5].value}%"),
        ),

        // profitMargin
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(SizeConstants.formSmallSpacing),
          child: Text("${row.getCells()[6].value}%"),
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
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'productName',
      width: 300,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Product Name',
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'stockItem',
      width: 100,
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Stock\nItem',
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'marketPrice',
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Market Price',
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'profitMargin',
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Profit Margin(%)',
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'sellingPrice',
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Selling Price',
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
    GridColumn(
      columnName: 'profitPerItem',
      label: Container(
        alignment: Alignment.center,
        child: Text(
          'Profit per Item',
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
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
          style: TextStyle(
            color: Color(ColorConstants.black),
            fontWeight: FontWeight.bold,
            fontSize: SizeConstants.titleMedium,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ];
}
