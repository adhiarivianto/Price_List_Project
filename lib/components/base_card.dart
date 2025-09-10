import 'package:flutter/material.dart';
import 'package:price_list/constants/constants.dart';

class BaseCard extends StatelessWidget {
  final Widget cardContent;

  const BaseCard({super.key, required this.cardContent});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Color(ColorConstants.funGreen),
          borderRadius: BorderRadius.circular(0), // round all corners
        ),
        child: cardContent,
      ),
    );
  }
}
