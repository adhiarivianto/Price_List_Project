import 'package:flutter/material.dart';
import 'package:price_list/components/base_card.dart';
import 'package:price_list/constants/constants.dart';

class StockItemPageView extends StatefulWidget {
  const StockItemPageView({super.key});

  @override
  State<StatefulWidget> createState() => _StockItemPageViewState();
}

class _StockItemPageViewState extends State<StockItemPageView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseCard(
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
                      return _newItemForm();
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
        ],
      ),
    );
  }

  Widget _newItemForm() {
    return AlertDialog(
      title: Text("Add New Item"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(constraints: BoxConstraints(minWidth: 500)),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Product Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    SizeConstants.formFieldRadius,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter product name";
                }
                return null;
              },
              onSaved: (value) {},
            ),
            SizedBox(height: SizeConstants.formSpacing),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Market Price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConstants.formFieldRadius,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter market price";
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(width: SizeConstants.formSpacing),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Profit Margin(%)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConstants.formFieldRadius,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter profit margin";
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // close the dialog
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Color(ColorConstants.stacks)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // close the dialog
          },
          child: Text(
            'Submit',
            style: TextStyle(color: Color(ColorConstants.funGreen)),
          ),
        ),
      ],
    );
  }
}
