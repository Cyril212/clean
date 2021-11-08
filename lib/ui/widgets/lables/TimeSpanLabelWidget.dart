import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class TimeSpanLabelWidget extends StatelessWidget {
  final DateTime startTime;
  final DateTime endTime;

  const TimeSpanLabelWidget({required this.startTime, required this.endTime});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SvgPicture.asset(
        'assets/icons/icon_clock.svg',
        color: kColorSecondary,
        height: 14,
      ),
      SizedBox(width: 6),
      Text(
        '${DateFormat.Hm().format(startTime)} - ${DateFormat.Hm().format(endTime)}',
        style: const TextStyle(color: kColorTextPrimary, fontSize: 11, height: 1.36, fontWeight: FontWeight.w600),
      ),
    ]);
  }
}
