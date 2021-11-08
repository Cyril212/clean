import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/job/Job.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CommonLabelWidget.dart';

class StatusLabelWidget extends StatelessWidget {
  final String? header;
  final JobStatus status;

  const StatusLabelWidget(this.status, {this.header});

  @override
  Widget build(BuildContext context) {
    Widget _setChildWidgetByColor(Color color, String text) {
      return Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(color: color, fontSize: 11, height: 1.36, fontWeight: FontWeight.w600),
          ),
        ],
      );
    }

    Widget child = Row(
      children: [
        SvgPicture.asset(
          'assets/icons/icon_check.svg',
          color: kColorSecondary,
          height: 12,
        ),
        SizedBox(width: 4),
        Text(
          'Dokončeno',
          style: const TextStyle(color: kColorTextPrimary, fontSize: 11, height: 1.36, fontWeight: FontWeight.w600),
        ),
      ],
    );
    switch (status) {
      case JobStatus.available:
        child = _setChildWidgetByColor(kColorPrimary, 'K dispozici');
        break;
      case JobStatus.confirmed:
        child = _setChildWidgetByColor(kColorGreen, 'Potvrzeno');
        break;
      case JobStatus.inProgress:
        child = _setChildWidgetByColor(kColorOrange, 'Probíhá');
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) CommonLabelWidget(header!),
        child,
      ],
    );
  }
}
