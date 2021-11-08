import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import 'DateCardWidget.dart';

class TimeSpanCardWidget extends StatelessWidget {
  final CardType type;
  final DateTime startDate;
  final DateTime endDate;

  const TimeSpanCardWidget({this.type = CardType.regular, required this.startDate, required this.endDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCardHeight,
      decoration: type == CardType.regular ? kCardBoxDecoration : kCompleteCardBoxDecoration,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(flex: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OD',
                style: TextStyle(
                    color: type == CardType.regular ? kColorTextPrimary.withOpacity(0.6) : kColorTextPrimary.withOpacity(0.5),
                    fontSize: 9,
                    height: 1.22,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat.Hm().format(startDate),
                style: TextStyle(
                    color: type == CardType.regular ? kColorTextPrimary : kColorTextPrimary.withOpacity(0.7),
                    fontSize: 19,
                    height: 1.4,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Spacer(flex: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DO',
                style: TextStyle(
                    color: type == CardType.regular ? kColorTextPrimary.withOpacity(0.6) : kColorTextPrimary.withOpacity(0.5),
                    fontSize: 9,
                    height: 1.22,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat.Hm().format(endDate),
                style: TextStyle(
                    color: type == CardType.regular ? kColorTextPrimary : kColorTextPrimary.withOpacity(0.7),
                    fontSize: 19,
                    height: 1.4,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Spacer(flex: 14),
        ],
      ),
    );
  }
}
