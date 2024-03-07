import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/input/text_form_field_widget.dart';
import 'package:get/get.dart';

import '../../widgets/button/custom_button.dart';
import '../home/home_controller.dart';

Future<void> openAddRss(HomeController controller) {
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
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      textLocalization('dialog.cancel'),
                      style: text12.bold.textColorFF6F15,
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
                        style: text16.bold.textColor141414,
                      ),
                      SizedBox(height: 16.ws),
                      Text(
                        textLocalization('feed.content'),
                        style: text12.textColorB2B2B2,
                      ),
                      SizedBox(height: 16.ws),
                      DTextFromField(
                        keyboardType: TextInputType.text,
                        controller: controller.textAddRssCl,
                        textStyle: text12.textColorB2B2B2,
                        hintText: textLocalization('feed.url'),
                        strokeColor: Colors.transparent,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 12.ws),
                        background: colorWhite,
                        onValidated: (val) {
                          return controller.validatorRss('Địa chỉ RSS');
                        },
                      ),
                      SizedBox(height: 16.ws),
                      CustomButton(
                        text: textLocalization('feed.add'),
                        onPressed: () => {},
                        isEnable: true,
                        width: 150.ws,
                        background: colorFF6F15,
                        textStyle: text12.bold.textColorWhite,
                        height: 42.ws,
                        radius: 32.rs,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.ws),
                  Text(
                    textLocalization('feed.popular.feeds'),
                    style: text16.bold.textColor141414,
                  ),
                  SizedBox(height: 8.ws),
                  Row(
                    children: [
                      Assets.icons.icYoutube.svg(),
                      Assets.icons.icVimeo.svg(),
                      Assets.icons.icDailymotion.svg(),
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
