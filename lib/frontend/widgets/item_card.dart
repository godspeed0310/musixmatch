import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ItemCard extends StatelessWidget {
  final IconData icon;
  final String value;

  const ItemCard({
    Key? key,
    required this.icon,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(
          height: 1.h,
        ),
        Text(value),
      ],
    );
  }
}
