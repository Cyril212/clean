import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum CardType { regular, complete }

class DateCardWidget extends StatelessWidget {
  final CardType type;
  final DateTime date;

  const DateCardWidget({this.type = CardType.regular, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCardHeight,
      width: 54,
      decoration: type == CardType.regular ? kCardBoxDecoration : kCompleteCardBoxDecoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.day.toString(),
            style: TextStyle(
                color: type == CardType.regular ? kColorTextPrimary : kColorTextPrimary.withOpacity(0.7),
                fontSize: 19,
                height: 1.4,
                fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat.MMM().format(date).toUpperCase(),
            style: TextStyle(
                color: type == CardType.regular ? kColorTextPrimary : kColorTextPrimary.withOpacity(0.7),
                fontSize: 11,
                height: 1.4,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
