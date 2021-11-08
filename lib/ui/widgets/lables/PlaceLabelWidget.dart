import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/job/Place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'CommonLabelWidget.dart';

class PlaceLabelWidget extends StatelessWidget {
  final PlaceType type;
  final String? header;

  const PlaceLabelWidget({this.type = PlaceType.house, this.header});

  @override
  Widget build(BuildContext context) {
    String icon = 'assets/icons/icon_house.svg';
    String text = 'Hotel';

    switch (type) {
      case PlaceType.apartment:
        icon = 'assets/icons/icon_apartment.svg';
        text = 'Apartmán';
        break;
      case PlaceType.office:
        icon = 'assets/icons/icon_office.svg';
        text = 'Kancelář';
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (header != null) CommonLabelWidget(header!),
        Row(
          children: [
            SvgPicture.asset(
              icon,
              height: 16,
              color: kColorSecondary,
            ),
            SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(fontSize: 11, height: 1.36, color: kColorTextPrimary),
            )
          ],
        ),
      ],
    );
  }
}
