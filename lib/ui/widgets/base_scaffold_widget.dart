import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

class ScaffoldBase extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final bool? isHome;

  ScaffoldBase({Key? key, required this.body, this.appBar, this.bottomNavigationBar, this.isHome = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(
        child: Material(
          child: Padding(
            padding: isHome == true ? EdgeInsets.only(left: 16.ws, top: 16.ws) : EdgeInsets.symmetric(horizontal: 16.ws, vertical: 16.ws),
            child: body,
          ),
        ),
      ),
    );
  }
}
