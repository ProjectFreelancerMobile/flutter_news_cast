import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

import '../../app/app_controller.dart';
import '../base/base_page.dart';
import '../payment/widget/button_next.dart';
import '../widgets/default_appbar.dart';
import 'settings_controller.dart';

//ignore: must_be_immutable
class SettingsPage extends BasePage<SettingsController> {
  @override
  Widget buildContentView(BuildContext context, SettingsController controller) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 24.ws),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: controller.themeMain(),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
            ),
          ),
          Column(
            children: [
              DefaultAppbar(
                title: 'Chọn hình nền',
                appBarStyle: AppBarStyle.BACK,
                color: Colors.transparent,
                onPress: () => Get.offAllNamed(AppRoutes.MAIN),
              ),
              Expanded(
                child: Stack(
                  children: [
                    buildWidgetTheme(),
                    Positioned(
                      left: 16.ws,
                      right: 16.ws,
                      bottom: 16.ws,
                      child: ButtonNext(
                        title: 'Đăng xuất',
                        onPress: () {
                          Get.find<AppController>().logout();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buildWidgetTheme() => SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TouchableOpacity(
                    onPressed: () {
                      controller.updateTheme(0);
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Assets.images.imgThemeBgTet.image(height: 250.ws),
                        ),
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Radio(
                            value: controller.indexTheme,
                            groupValue: 0,
                            onChanged: (value) {
                              controller.updateTheme(0);
                            },
                            activeColor: Colors.white,
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TouchableOpacity(
                    onPressed: () {
                      controller.updateTheme(1);
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Assets.images.imgThemeBgMain.image(height: 250.ws),
                        ),
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Radio(
                            value: controller.indexTheme,
                            groupValue: 1,
                            onChanged: (value) {
                              controller.updateTheme(1);
                            },
                            activeColor: Colors.white,
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TouchableOpacity(
                    onPressed: () {
                      controller.updateTheme(2);
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Assets.images.imgThemeBgMain2.image(height: 250.ws),
                        ),
                        Theme(
                          data: ThemeData(
                            unselectedWidgetColor: Colors.white,
                          ),
                          child: Radio(
                            value: controller.indexTheme,
                            groupValue: 2,
                            onChanged: (value) {
                              controller.updateTheme(2);
                            },
                            activeColor: Colors.white,
                            fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            SizedBox(height: 100.ws),
          ],
        ),
      );
}
