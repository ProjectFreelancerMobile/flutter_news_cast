import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

class ScaffoldBase extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool? offMarginVertical;

  ScaffoldBase({Key? key, required this.body, this.appBar, this.offMarginVertical, this.bottomNavigationBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Material(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.ws, vertical: offMarginVertical == true ? 0 : 30.ws),
            child: body,
          ),
        ),
      ),
    );
  }
}
