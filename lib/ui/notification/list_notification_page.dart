import 'dart:ui' as ui show PlaceholderAlignment;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:get/get.dart';

import '../../data/api/models/notification_item.dart';
import '../../res/theme/theme_service.dart';
import '../../ui/base/base_list_page.dart';
import '../../ui/notification/list_notification_controller.dart';
import '../widgets/image_widget.dart';

//ignore: must_be_immutable
class ListNotificationPage extends BaseListPage<NotificationItem, ListNotificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 16.ws),
            child: Image.asset(DImages.back),
          ),
        ),
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: _buildTitleAppBar(context),
        actions: [
          _rightAction(context),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: super.build(context),
    );
  }

  Widget _buildTitleAppBar(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: RichText(
          text: TextSpan(children: [
            TextSpan(text: "Tất cả hoạt động", style: text18.bold.textColor141414),
            WidgetSpan(
                alignment: ui.PlaceholderAlignment.middle,
                child: Image.asset(
                  DImages.arrowBottom,
                  width: 18,
                  height: 18,
                )),
          ]),
        ),
      ),
    );
  }

  Widget _rightAction(BuildContext context) {
    return IconButton(
      iconSize: 32,
      padding: EdgeInsets.only(right: 16.ws),
      icon: Image.asset(
        DImages.checkNoti,
        width: 32.ws,
        height: 32.ws,
      ),
      onPressed: () async {},
    );
  }

  @override
  Widget buildItem(BuildContext context, NotificationItem item, int index) {
    Widget itemBuild;
    switch (item.type) {
      case "account":
        itemBuild = _buildAccountItem(context, item, index);
        break;
      case "payment":
        itemBuild = _buildSystemItem(context, item, index, icon: DImages.notiPayment);
        break;
      default:
        itemBuild = _buildSystemItem(context, item, index);
        break;
    }
    return Obx(
      () => InkWell(
        onTap: () {
          if (item.isRead?.value == false) {
            item.isRead?.value = true;
          }
        },
        child: Container(
          color: item.isRead?.value == true ? getColor().themeColorWhite : getColor().themeColorE5F2FF,
          child: itemBuild,
        ),
      ),
    );
  }

  Widget _buildSystemItem(BuildContext context, NotificationItem item, int index, {String? icon}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.ws, right: 13.ws, top: 16.ws),
          child: Image.asset(
            icon ?? DImages.notiDiscount,
            height: 40.ws,
            width: 40.ws,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                item.title ?? "",
                style: text16.medium.textColor141414,
              ),
              SizedBox(
                height: 5.ws,
              ),
              Text(
                item.content ?? "",
                style: text14.textColor141414,
              ),
              SizedBox(
                height: 5.ws,
              ),
              Text(
                "12 giờ trước",
                style: text14.textColor777777,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildAccountItem(BuildContext context, NotificationItem item, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.ws, right: 13.ws, top: 16.ws),
          child: RoundNetworkImage(
            width: 40.ws,
            height: 40.ws,
            url: item.image,
            radius: 20,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                item.content ?? "",
                style: text16.medium.textColor141414,
              ),
              SizedBox(
                height: 5.ws,
              ),
              Text(
                "12 giờ trước",
                style: text14.textColorB2B2B2,
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        )
      ],
    );
  }
}
