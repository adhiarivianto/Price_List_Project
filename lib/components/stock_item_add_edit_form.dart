import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:price_list/constants/constants.dart';
import 'package:price_list/models/models.dart';

class StockItemAddEditForm extends StatefulWidget {
  final StockItems? savedData;

  const StockItemAddEditForm({super.key, this.savedData});

  @override
  State<StatefulWidget> createState() => _StockItemAddEditFormState();
}

class _StockItemAddEditFormState extends State<StockItemAddEditForm> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _marginController = TextEditingController();
  final _stockController = TextEditingController();

  Uint8List? _imageInput;
  String _nameInput = '';
  double _priceInput = 0;
  double _marginInput = 0;
  int _stockInput = 0;

  double? _profitCalculation;

  @override
  void initState() {
    if (widget.savedData != null) {
      _imageInput = widget.savedData?.productImage;
      _nameInput = widget.savedData?.productName ?? '';
      _priceInput = widget.savedData?.marketPrice ?? 0;
      _marginInput = widget.savedData?.profitMargin ?? 0;
      _stockInput = widget.savedData?.stockItem ?? 0;

      _nameController.text = widget.savedData?.productName ?? '';
      _priceController.text = widget.savedData?.marketPrice.toString() ?? '';
      _marginController.text = widget.savedData?.profitMargin.toString() ?? '';
      _stockController.text = widget.savedData?.stockItem.toString() ?? '';

      calculateProfit(
        marketPrice: widget.savedData?.marketPrice,
        profitMargin: widget.savedData?.profitMargin,
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _marginController.dispose();
    _stockController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Item"),
      backgroundColor: Color(ColorConstants.wildSand),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.5,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter product name.";
                  }
                  return null;
                },
                onChanged: (value) {
                  _nameInput = value;
                  setState(() {});
                },
                decoration: InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      SizeConstants.formFieldRadius,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConstants.formSpacing),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyInputFormatter()],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter market price.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _priceInput = double.parse(
                          toNumericString(value, allowPeriod: true),
                        );
                        calculateProfit(
                          marketPrice: _priceInput,
                          profitMargin: _marginInput,
                        );
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "Market Price",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            SizeConstants.formFieldRadius,
                          ),
                        ),
                        suffixIcon: _priceController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: SizeConstants.mediumIcon,
                                ),
                                onPressed: () {
                                  _priceController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConstants.formSpacing),
                  Expanded(
                    child: TextFormField(
                      controller: _marginController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CurrencyInputFormatter()],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter profit margin.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _marginInput = double.parse(
                          toNumericString(value, allowPeriod: true),
                        );
                        calculateProfit(
                          marketPrice: _priceInput,
                          profitMargin: _marginInput,
                        );
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "Profit Margin(%)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            SizeConstants.formFieldRadius,
                          ),
                        ),
                        suffixIcon: _marginController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: SizeConstants.mediumIcon,
                                ),
                                onPressed: () {
                                  _marginController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConstants.formSpacing),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _stockController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyInputFormatter(mantissaLength: 0),
                      ],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter stock quantity.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _stockInput = int.parse(toNumericString(value));
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: "Stock Quantity",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            SizeConstants.formFieldRadius,
                          ),
                        ),
                        suffixIcon: _stockController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  size: SizeConstants.mediumIcon,
                                ),
                                onPressed: () {
                                  _stockController.clear();
                                  setState(() {});
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConstants.formSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Profit per Item',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          toCurrencyString(_profitCalculation.toString()),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConstants.formSpacing),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          width: double.infinity,
                          color: Colors.amber,
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                    ColorConstants.funGreen,
                  ), // background color
                  foregroundColor: Color(ColorConstants.wildSand), // text color
                  padding: EdgeInsets.symmetric(horizontal: 10),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.upload, size: SizeConstants.mediumIcon),
                    Text('Choose Image'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(ColorConstants.stacks)),
          ),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop();
            }
          },
          child: Text(
            'Submit',
            style: TextStyle(color: Color(ColorConstants.funGreen)),
          ),
        ),
      ],
    );
  }

  void calculateProfit({
    required double? marketPrice,
    required double? profitMargin,
  }) {
    if (marketPrice != null && profitMargin != null) {
      _profitCalculation = marketPrice * (profitMargin / 100);
    } else {
      _profitCalculation = null;
    }
  }
}
