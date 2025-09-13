import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:price_list/constants/constants.dart';
import 'package:price_list/models/models.dart';
import 'package:price_list/storages/boxes.dart';
import 'package:uuid/uuid.dart';

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
      title: const Text('Add New Item'),
      backgroundColor: const Color(ColorConstants.wildSand),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.5,
          maxWidth: MediaQuery.of(context).size.width * 0.5,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: SingleChildScrollView(
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
                      return 'Please enter product name.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _nameInput = value;
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        SizeConstants.formFieldRadius,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: SizeConstants.formRegularSpacing),
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
                            return 'Please enter market price.';
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
                          labelText: 'Market Price',
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
                    const SizedBox(width: SizeConstants.formRegularSpacing),
                    Expanded(
                      child: TextFormField(
                        controller: _marginController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CurrencyInputFormatter()],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter profit margin.';
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
                          labelText: 'Profit Margin(%)',
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
                const SizedBox(height: SizeConstants.formRegularSpacing),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: TextFormField(
                        controller: _stockController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          CurrencyInputFormatter(mantissaLength: 0),
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter stock quantity.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _stockInput = int.parse(toNumericString(value));
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          labelText: 'Stock Quantity',
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
                    const SizedBox(width: SizeConstants.formRegularSpacing),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Profit per Item',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: SizeConstants.formSmallSpacing,
                          ),
                          Text(
                            toCurrencyString(_profitCalculation.toString()),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SizeConstants.formRegularSpacing),
                Column(
                  children: [
                    if (_imageInput != null) ...[
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return _imageViewerDialog();
                            },
                          );
                        },
                        child: Image.memory(
                          _imageInput!,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: SizeConstants.formSmallSpacing),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => pickImage(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              ColorConstants.funGreen,
                            ), // background color
                            foregroundColor: const Color(
                              ColorConstants.wildSand,
                            ), // text color
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.upload,
                                size: SizeConstants.mediumIcon,
                              ),
                              Text('Choose Image'),
                            ],
                          ),
                        ),
                        if (_imageInput != null) ...[
                          Padding(
                            padding: const EdgeInsetsGeometry.only(
                              left: SizeConstants.formSmallSpacing,
                            ),
                            child: IconButton(
                              onPressed: () {
                                _imageInput = null;
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Color(ColorConstants.boulder),
                                size: SizeConstants.largeIcon,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(ColorConstants.stacks)),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await _submitForm();
              Navigator.of(context).pop();
            }
          },
          child: const Text(
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

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      if (result.files.single.bytes != null) {
        // bytes -> usually for browser
        setState(() {
          _imageInput = result.files.single.bytes!;
        });
      } else if (result.files.single.path != null) {
        //path -> works for desktop app
        setState(() {
          _imageInput = File(result.files.single.path!).readAsBytesSync();
        });
      }
    }
  }

  Widget _imageViewerDialog() {
    return AlertDialog(
      backgroundColor: const Color(ColorConstants.wildSand),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.25,
          maxWidth: MediaQuery.of(context).size.width * 0.75,
          minHeight: MediaQuery.of(context).size.height * 0.25,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: InteractiveViewer(
          child: _imageInput != null
              ? Image.memory(_imageInput!, fit: BoxFit.cover)
              : Container(),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    final StockItems payload = StockItems(
      productId: const Uuid().v4(),
      productImage: _imageInput,
      productName: _nameInput,
      marketPrice: _priceInput,
      profitMargin: _marginInput,
      stockItem: _stockInput,
    );

    final method = Boxes.getStockItemBoxMethod();
    await method.add(payload);
  }
}
