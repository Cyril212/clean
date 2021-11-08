import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';

class OneLineListItemWidget extends StatelessWidget {
  final String label;
  final String value;

  const OneLineListItemWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.2, color: kColorTextPrimary),
        ),
        Spacer(),
        Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.2, color: kColorTextPrimary)),
      ],
    );
  }
}
