import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/res/style.dart';

class HomeNotifyEmptyView extends StatelessWidget {
  const HomeNotifyEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.icons.home.icEmptyHome.svg(width: 60.ws),
        SizedBox(height: 16.ws),
        Text('Hiện tại không có biến động số dư nào.', style: text14.textColorWhite, textAlign: TextAlign.center),
      ],
    );
  }
}
