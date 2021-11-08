import 'package:clean/core/AppTheme.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  final List<Widget> tabs;
  final TabController controller;

  const TabBarWidget({required this.tabs, required this.controller});

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffFDFDFD),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 5,
              color: Color(0xffE6E9EF),
              width: double.infinity,
            ),
          ),
          TabBar(
            controller: widget.controller,
            tabs: widget.tabs,
            indicatorColor: kColorBlue,
            indicatorWeight: 5,
          ),
        ],
      ),
    );
  }
}
