import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/data/api/models/device/device_item.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/button/touchable_opacity.dart';
import '../../../widgets/image_widget.dart';

class HomeItemView extends StatelessWidget {
  final DeviceItem deviceItem;
  final VoidCallback onPressed;
  final Function(bool) onPressedControl;

  HomeItemView({required this.deviceItem, required this.onPressed, required this.onPressedControl});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 8.ws),
        decoration: BoxDecoration(color: deviceItem.connecting == false ? colorPrimary.withOpacity(0.55) : colorPrimary, borderRadius: BorderRadius.all(Radius.circular(8.rs))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundNetworkImage(
                  width: 12.ws,
                  height: 26.ws,
                  boxFit: BoxFit.fitHeight,
                  url: deviceItem.icon ?? "",
                ),
                deviceItem.data != null
                    ? ((deviceItem.isControl == true)
                        ? TouchableOpacity(
                            onPressed: () {
                              onPressedControl(deviceItem.isOn == true);
                            },
                            child: SvgPicture.asset(
                              deviceItem.getIcon ?? "",
                              width: 30.ws,
                              height: 30.ws,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Text(deviceItem.data ?? '', style: text20.textColorD67402))
                    : SizedBox(),
              ],
            ),
            Text(deviceItem.deviceTypeName ?? '', style: text14.textColorWhite, maxLines: 2, overflow: TextOverflow.ellipsis),
            Text(deviceItem.name ?? '', style: text14.textColorWhite, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
