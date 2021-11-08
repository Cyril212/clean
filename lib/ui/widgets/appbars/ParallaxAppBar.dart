import 'dart:math';

import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/job/Contact.dart';
import 'package:clean/ui/widgets/modals/ContactsModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';
import 'package:tch_common_widgets/tch_common_widgets.dart';

class ParallaxAppBar extends StatelessWidget {
  final Widget child;
  final List<Contact> contacts;

  const ParallaxAppBar({required this.child, this.contacts = const []});

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: ParallaxHeaderDelegate(child: child, contacts: contacts),
      pinned: true,
    );
  }
}

class ParallaxHeaderDelegate implements SliverPersistentHeaderDelegate {
  final Widget child;
  final List<Contact> contacts;

  const ParallaxHeaderDelegate({required this.child, this.contacts = const []});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(fit: StackFit.expand, children: [
      Positioned(
        left: 0,
        right: 0,
        bottom: -shrinkOffset,
        child: Container(
          height: maxExtent,
          child: Opacity(
            opacity: childOpacity(shrinkOffset),
            child: child,
          ),
        ),
      ),
      if (Navigator.of(context).canPop() == true)
        Positioned(
            top: backButtonTopPosition(context, shrinkOffset),
            left: 14,
            child: Builder(
              builder: (BuildContext context) {
                return IconButtonWidget(
                  style: kParallaxAppBarIconButtonStyle,
                  svgAssetPath: 'assets/icons/icon_back.svg',
                  onTap: () {
                    popNotDisposed(context, true);
                  },
                );
              },
            )),
      if (contacts.length > 0)
        Positioned(
            top: backButtonTopPosition(context, shrinkOffset),
            right: 14,
            child: Builder(
              builder: (BuildContext context) {
                return IconButtonWidget(
                  style: kParallaxAppBarIconButtonStyle,
                  svgAssetPath: 'assets/icons/phone.svg',
                  onTap: () {
                    ContactsModal.show(context, contacts);
                  },
                );
              },
            ))
    ]);
  }

  double backButtonTopPosition(BuildContext context, double shrinkOffset) {
    ///statusbar height + 6 is top coordinate when appbar is shrinked
    return 34 * (1 - (shrinkOffset / maxExtent)) + MediaQuery.of(context).padding.top + 6;
  }

  double childOpacity(double shrinkOffset) {
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  double get maxExtent => 256;

  @override
  double get minExtent => 48 + 26;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  TickerProvider? get vsync => null;

  @override
  PersistentHeaderShowOnScreenConfiguration? get showOnScreenConfiguration => null;

  @override
  FloatingHeaderSnapConfiguration? get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration? get stretchConfiguration => null;
}
