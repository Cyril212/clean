import 'package:clean/core/AppTheme.dart';
import 'package:clean/ui/widgets/buttons/ContainedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobsErrorStateWidget extends StatelessWidget {
  final GestureTapCallback? onTap;

  const JobsErrorStateWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(flex: 122),
        Expanded(flex: 190, child: SvgPicture.asset('assets/images/illustration_error.svg')),
        Spacer(flex: 47),
        Text(
          'Něco se nepovdelo!',
          style: TextStyle(fontSize: 17, color: kColorTextPrimary, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        Text(
          'Zkuste to znovu',
          style: TextStyle(fontSize: 13, color: kColorTextPrimary),
        ),
        SizedBox(height: 23),
        ContainedButtonWidget(
          text: 'Aktualizovat',
          prefixIconSvgAssetPath: 'assets/icons/icon_refresh.svg',
          widthWrapContent: true,
          onTap: onTap,
        ),
        Spacer(flex: 144),
      ],
    );
  }
}
