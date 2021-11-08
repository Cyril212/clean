import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabItemWidget extends StatelessWidget {
  final String tabIcon;
  final String title;
  final String description;

  const TabItemWidget({required this.tabIcon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 98,
      child: Tab(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              tabIcon,
              height: 32,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: kText.copyWith(fontWeight: FontWeight.w600, height: 1.5, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            Text(
              description,
              style: kText.copyWith(fontWeight: FontWeight.w600, height: 1.5, color: Color(0xff252E3B).withOpacity(0.6), fontSize: 11),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}
