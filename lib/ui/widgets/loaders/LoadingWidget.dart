import 'package:clean/core/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingWidget extends StatefulWidget {
  final double size;
  final Key? containerKey;

  const LoadingWidget({this.size = 32, this.containerKey});

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 14),
          // key: widget.containerKey,
          child: RotationTransition(
            child: SvgPicture.asset(
              'assets/icons/ios_spinner.svg',
              height: widget.size,
              color: kColorSecondary,
            ),
            turns: _controller!,
          ),
        ),
      ],
    );


    // return SliverList(
    //   delegate: SliverChildListDelegate([
    //     IntrinsicHeight(
    //       key: widget.containerKey,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Expanded(
    //             child: RotationTransition(
    //               child: SvgPicture.asset(
    //                 'assets/icons/ios_spinner.svg',
    //                 height: widget.size,
    //                 color: kColorSecondary,
    //               ),
    //               turns: _controller!,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ]),
    // );
  }
}
