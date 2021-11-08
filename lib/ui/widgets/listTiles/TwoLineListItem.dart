import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';

class TwoLineListItemWidget extends StatelessWidget {
  final String label;
  final String subHeader;
  final String value;
  final Function? onTap;

  const TwoLineListItemWidget({required this.label, required this.subHeader, required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap != null
            ? () {
                onTap!();
              }
            : null,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, height: 1.2, color: kColorTextPrimary),
                ),
                SizedBox(height: 4),
                Text(subHeader, style: TextStyle(fontSize: 11)),
              ],
            ),
            Spacer(),
            Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, height: 1.2, color: kColorTextPrimary)),
          ],
        ),
      ),
    );
  }
}
