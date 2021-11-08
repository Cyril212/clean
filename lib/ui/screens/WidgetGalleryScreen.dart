import 'package:clean/ui/widgets/appbars/PrimaryAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetGalleryScreen extends StatefulWidget {
  static const String ROUTE = '/widget-gallery';

  const WidgetGalleryScreen({Key? key}) : super(key: key);

  @override
  _WidgetGalleryScreenState createState() => _WidgetGalleryScreenState();
}

class _WidgetGalleryScreenState extends State<WidgetGalleryScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppbar(
        onPressed: () {},
      ),
    );
  }
}
