import 'package:clean/core/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../custom/SliverFillRemainingBoxAdapter.dart';

class SliverLoadingWidget extends StatefulWidget {
  final double size;
  final Key? containerKey;

  const SliverLoadingWidget({this.size = 32, this.containerKey});

  @override
  _SliverLoadingWidgetState createState() => _SliverLoadingWidgetState();
}

class _SliverLoadingWidgetState extends State<SliverLoadingWidget> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))..repeat();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SliverFillRemainingBoxAdapter(
      key: widget.containerKey!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotationTransition(
            child: SvgPicture.asset(
              'assets/icons/ios_spinner.svg',
              height: widget.size,
              color: kColorSecondary,
            ),
            turns: _controller!,
          ),
        ],
      ),
    );
  }
}
