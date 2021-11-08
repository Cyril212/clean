import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';

class CommonLabelWidget extends StatelessWidget {
  final String text;

  const CommonLabelWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 9, height: 1.22, fontWeight: FontWeight.w600, color: kColorTextPrimary),
      ),
    );
  }
}
