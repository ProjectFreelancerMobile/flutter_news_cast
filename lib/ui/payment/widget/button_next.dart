import 'package:flutter/material.dart';

import '../../../res/style.dart';
import '../../widgets/button/custom_button.dart';

class ButtonNext extends StatelessWidget {
  final VoidCallback onPress;
  final String? title;
  const ButtonNext({super.key, required this.onPress, this.title = 'Tiếp tục'});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: title ?? 'Tiếp tục',
      onPressed: onPress,
      isEnable: true,
      width: double.infinity,
      textStyle: text16.bold.textColorWhite,
      height: 46.ws,
      radius: 5.rs,
      imageBackground: Assets.images.payment.bgButton.image().image,
    );
  }
}
