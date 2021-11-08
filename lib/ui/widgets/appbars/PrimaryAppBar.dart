import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

class PrimaryAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onPressed;

  const PrimaryAppbar({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Color(0xffFDFDFD),
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SvgPicture.asset('assets/icons/clean.svg'),
      ),
      actions: [
        if (onPressed != null)
          Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(right: 11),
              child: IconButtonWidget(
                  style: IconButtonStyle(
                    variant: IconButtonVariant.IconOnly,
                  ),
                  onTap: onPressed,
                  svgAssetPath: 'assets/icons/icon_settings.svg'),
            );
          })
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 48);
}
