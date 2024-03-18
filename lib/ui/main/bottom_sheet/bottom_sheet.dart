import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_news_cast/ui/widgets/input/text_form_field_widget.dart';
import 'package:flutter_news_cast/ui/widgets/loading_widget.dart';
import 'package:get/get.dart';

import '../../widgets/button/custom_button.dart';
import '../../widgets/button/text_button_widget.dart';
import '../home/home_controller.dart';

Future<void> openBottomSheetAddRss(HomeController controller) {
  return Get.bottomSheet(
    isScrollControlled: true,
    Container(
      width: double.infinity,
      height: Get.height * 0.93,
      padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 16.ws),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height * 0.88,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ButtonIconTextWidget(
                    onPressed: () {
                      controller.clearInputRss();
                      controller.textAddRssCl.clear();
                      Get.back();
                    },
                    text: Text(
                      textLocalization('dialog.cancel'),
                      style: text16.bold.textColorFF6F15,
                    ),
                  ),
                  SizedBox(height: 60.ws),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Assets.icons.icFeedBig.svg(),
                      SizedBox(height: 16.ws),
                      Text(
                        textLocalization('feed.title'),
                        style: text18.bold.textColor141414,
                      ),
                      SizedBox(height: 16.ws),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: textLocalization('feed.content1'),
                          style: text16.textColor141414,
                          children: <TextSpan>[
                            TextSpan(text: textLocalization('feed.content2'), style: text16.bold.textColor141414),
                            TextSpan(text: textLocalization('feed.content3')),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.ws),
                      Obx(
                        () => Stack(
                          children: [
                            Visibility(
                              visible: controller.addRssLoading,
                              child: LoadingWidget(),
                            ),
                            Visibility(
                              visible: controller.addRssExist,
                              child: Text(textLocalization('error.url.exist'), style: text16.textColorFF6F15),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 16.ws),
                      ClearTextField(
                        keyboardType: TextInputType.text,
                        controller: controller.textAddRssCl,
                        textStyle: text16.textColor141414,
                        hint: textLocalization('feed.url'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 12.ws),
                        background: colorWhite,
                        onClear: () {
                          controller.clearInputRss();
                        },
                        onValidated: (val) {
                          return controller.validatorRss('Địa chỉ RSS');
                        },
                      ),
                      SizedBox(height: 16.ws),
                      CustomButton(
                        text: textLocalization('feed.add'),
                        onPressed: () {
                          controller.saveRssFeed();
                        },
                        isEnable: true,
                        width: 150.ws,
                        background: colorFF6F15,
                        textStyle: text16.bold.textColorWhite,
                        height: 42.ws,
                        radius: 32.rs,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.ws),
                  Text(
                    textLocalization('feed.popular.feeds'),
                    style: text18.bold.textColor141414,
                  ),
                  SizedBox(height: 8.ws),
                  Row(
                    children: [
                      Assets.icons.icYoutubeText.svg(),
                      Assets.icons.icVimeoText.svg(),
                      Assets.icons.icDailymotionText.svg(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.rs),
    ),
    backgroundColor: colorWhite,
    elevation: 1,
  );
}

Future<void> openBottomSheetSelectDevice(HomeController controller) {
  return Get.bottomSheet(
    isScrollControlled: true,
    Container(
      width: double.infinity,
      height: Get.height * 0.3,
      padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 16.ws),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height * 0.26,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 12.ws),
                  Row(
                    children: [
                      Text(
                        textLocalization('dialog.select.device'),
                        style: text18.bold.textColor141414,
                      ),
                      SizedBox(width: 16.ws),
                      SizedBox(
                        width: 20.ws,
                        height: 20.ws,
                        child: CircularProgressIndicator(
                          color: Colors.black,
                          strokeWidth: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.ws),
                  Row(
                    children: [
                      Assets.icons.icLocalPhone.svg(),
                      SizedBox(width: 16.ws),
                      Text(
                        textLocalization('dialog.local.playback'),
                        style: text16.textColor141414,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.ws),
                  Row(
                    children: [
                      Assets.icons.icAirplay.svg(),
                      SizedBox(width: 16.ws),
                      Text(
                        textLocalization('dialog.airplay'),
                        style: text16.textColor141414,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.ws),
                  Row(
                    children: [
                      Assets.icons.icLearnMore.svg(),
                      SizedBox(width: 16.ws),
                      Text(
                        textLocalization('dialog.learn.more'),
                        style: text16.textColor141414,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.rs),
    ),
    backgroundColor: colorWhite,
    elevation: 1,
  );
}

Future<void> openBottomSheetScanDevice(HomeController controller) {
  return Get.bottomSheet(
    isScrollControlled: true,
    Container(
      width: double.infinity,
      height: Get.height * 0.4,
      padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 16.ws),
      decoration: BoxDecoration(
        color: colorBackground,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          height: Get.height * 0.36,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 12.ws),
                  Text(
                    textLocalization('dialog.no.device'),
                    style: text18.bold.textColor141414,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.ws),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textLocalization('dialog.local.network'),
                            style: text16.bold.textColor141414,
                          ),
                          SizedBox(height: 12.ws),
                          Text(
                            textLocalization('dialog.local.setting'),
                            style: text16.textColor141414,
                          ),
                          SizedBox(height: 12.ws),
                          TouchableOpacity(
                            child: Text(
                              textLocalization('settings.title'),
                              style: text16.medium.textColorPrimary,
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(height: 24.ws),
                          Text(
                            textLocalization('dialog.check.wifi'),
                            style: text16.bold.textColor141414,
                          ),
                          SizedBox(height: 12.ws),
                          Text(
                            textLocalization('dialog.cast.device'),
                            style: text16.textColor141414,
                          ),
                          SizedBox(height: 12.ws),
                          TouchableOpacity(
                            child: Text(
                              textLocalization('dialog.learn.more'),
                              style: text16.medium.textColorPrimary,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.rs),
    ),
    backgroundColor: colorWhite,
    elevation: 1,
  );
}
