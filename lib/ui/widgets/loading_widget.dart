import 'package:flutter/cupertino.dart';
import 'package:flutter_news_cast/res/style.dart';

class LoadingWidget extends StatefulWidget {
  final double? radius;

  const LoadingWidget({Key? key, this.radius = 16}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: widget.radius!,
      color: colorFF6F15,
    );
  }
}
