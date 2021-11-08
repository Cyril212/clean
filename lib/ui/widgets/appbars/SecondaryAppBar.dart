import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

const kTextAppBarTitle = const TextStyle(color: kColorTextPrimary, fontSize: 16, fontFamily: kFontFamilySemiBold);

class SecondaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SecondaryAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Color(0xffFDFDFD),
      centerTitle: true,
      title: Text(
        title,
        style: kTextAppBarTitle,
      ),
      leading: Navigator.of(context).canPop() == true
          ? Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButtonWidget(
                    style: kAppBarIconButtonStyle,
                    svgAssetPath: 'assets/icons/icon_back.svg',
                    onTap: () {
                      popNotDisposed(context, true);
                    },
                  ),
                );
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 48);
}
