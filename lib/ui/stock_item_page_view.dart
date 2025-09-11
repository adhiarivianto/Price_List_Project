import 'package:flutter/material.dart';
import 'package:price_list/components/base_card.dart';
import 'package:price_list/components/stock_item_add_edit_form.dart';
import 'package:price_list/constants/constants.dart';

class StockItemPageView extends StatefulWidget {
  const StockItemPageView({super.key});

  @override
  State<StatefulWidget> createState() => _StockItemPageViewState();
}

class _StockItemPageViewState extends State<StockItemPageView> {
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
        ],
      ),
    );
  }
}
