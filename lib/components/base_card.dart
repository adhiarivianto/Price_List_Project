import 'package:flutter/material.dart';
import 'package:price_list/constants/constants.dart';

class BaseCard extends StatelessWidget {
  final Widget cardContent;
  final bool isExpanded;

  const BaseCard({
    super.key,
    required this.cardContent,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(ColorConstants.funGreen),
                borderRadius: BorderRadius.circular(15), // round all corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: cardContent,
              ),
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: const Color(ColorConstants.funGreen),
              borderRadius: BorderRadius.circular(15), // round all corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: cardContent,
            ),
          );
  }
}
