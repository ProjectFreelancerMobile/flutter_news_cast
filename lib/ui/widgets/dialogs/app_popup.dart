import 'package:flutter/material.dart';
import 'package:flutter_news_cast/data/api/models/farm/farm_item.dart';

import '../../../res/style.dart';
import '../button/touchable_opacity.dart';

class AppPopup {
  final BuildContext context;
  final Function(FarmItem?)? onFarmDetailsPressed;
  final Function(FarmItem?)? onFarmEditPressed;
  final VoidCallback? onAddFarmPressed;
  OverlayEntry? _popupDialog = null;
  static List<FarmItem>? listFarm = null;
  static bool pairDevice = false;

  AppPopup({
    required this.context,
    this.onFarmDetailsPressed,
    this.onFarmEditPressed,
    this.onAddFarmPressed,
  });

  void showPopupDialog(BuildContext context, Offset offset) {
    if (_popupDialog != null) {
      removePopup();
      return;
    }
    _popupDialog = _buildPopupDialog(offset);
    if (_popupDialog != null) {
      Overlay.of(context).insert(_popupDialog!);
    }
  }

  void removePopup() {
    if (_popupDialog != null) {
      _popupDialog?.remove();
      _popupDialog = null;
    }
  }

  void setListFarm(List<FarmItem> listData) {
    listFarm = listData;
  }

  OverlayEntry _buildPopupDialog(Offset offset) {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx - 220.ws,
        top: offset.dy + 50.ws,
        child: Card(
          shadowColor: Colors.black,
          elevation: 16,
          child: Container(
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.all(Radius.circular(10.rs)),
            ),
            constraints: BoxConstraints(minWidth: 270.ws, maxWidth: 270.ws, minHeight: 100.ws, maxHeight: 300.ws),
            padding: EdgeInsets.only(top: 12.ws, bottom: 12.ws, left: 22.ws, right: 16.ws),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                listFarm?.isNotEmpty == true
                    ? Flexible(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = listFarm?[index];
                            return TouchableOpacity(
                              onPressed: () {
                                removePopup();
                                onFarmDetailsPressed?.call(item);
                              },
                              child: Container(
                                height: 40.ws,
                                padding: EdgeInsets.only(top: 8.ws),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(child: Text(item?.name ?? "", style: text14.textColor141414.height16Per, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                    Text("${(item?.acreage ?? 0.0).toStringAsFixed(1)}${item?.unit ?? ""}", style: text14.textColorB2B2B2),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: listFarm?.length,
                        ),
                      )
                    : SizedBox(),
                SizedBox(height: 12.ws),
                listFarm?.isNotEmpty == true ? Divider(height: 1, thickness: 0.5, color: color929394) : SizedBox(),
                TouchableOpacity(
                  child: Container(
                    height: 40.ws,
                    padding: EdgeInsets.only(top: 12.ws),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(textLocalization('home.device.add.farm'), style: text14.textColor141414.height16Per),
                        Assets.icons.icDeviceAdd.svg(color: color141414),
                      ],
                    ),
                  ),
                  onPressed: () {
                    removePopup();
                    onAddFarmPressed?.call();
                  },
                ),
                TouchableOpacity(
                  child: Container(
                    height: 40.ws,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(textLocalization('home.device.manager.farm'), style: text14.textColor141414.height16Per),
                        Assets.icons.icSettings.svg(),
                      ],
                    ),
                  ),
                  onPressed: () {
                    removePopup();
                    onFarmEditPressed?.call(null);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
