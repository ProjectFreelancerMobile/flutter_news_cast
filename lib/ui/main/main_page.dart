import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/main/cast/cast_page.dart';

import '../../ui/base/base_page.dart';
import '../../ui/main/main_controller.dart';
import '../../ui/widgets/menu/custom_bottom_menu.dart';
import 'home/home_page.dart';
import 'settings/settings_page.dart';

//ignore: must_be_immutable
class MainPage extends BasePage<MainController> {
  final List<Widget> pages = [HomePage(), CastPage(), SettingsPage()];

  @override
  Widget buildContentView(BuildContext context, MainController controller) {
    initToast(context);
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        label: 'Menu',
        icon: Assets.icons.icMenuHome.svg(),
        activeIcon: Container(
          width: 50.ws,
          height: 35.ws,
          padding: EdgeInsets.symmetric(vertical: 9.ws),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(20.rs),
          ),
          child: Assets.icons.icMenuHome.svg(),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Menu',
        icon: Assets.icons.icMenuCast.svg(),
        activeIcon: Container(
          width: 50.ws,
          height: 35.ws,
          padding: EdgeInsets.symmetric(vertical: 10.ws),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(20.rs),
          ),
          child: Assets.icons.icMenuCast.svg(),
        ),
      ),
      BottomNavigationBarItem(
        label: 'Menu',
        icon: Assets.icons.icMenuSetting.svg(),
        activeIcon: Container(
          width: 50.ws,
          height: 35.ws,
          padding: EdgeInsets.symmetric(vertical: 8.ws),
          decoration: BoxDecoration(
            color: colorWhite,
            borderRadius: BorderRadius.circular(20.rs),
          ),
          child: Assets.icons.icMenuSetting.svg(),
        ),
      ),
    ];
    return Scaffold(
      body: buildPage(context),
      bottomNavigationBar: CustomBottomNenu(
        index: controller.pageIndex.value,
        items: items,
        backgroundColor: colorBackground,
        onTabChanged: (value) {
          controller.onTabChanged(value);
        },
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorWhite,
      ),
    );
  }

  buildPage(BuildContext context) {
    if (!controller.checkConnect.value) {
      Future.delayed(Duration(seconds: 1), () {
        showMessage(textLocalization('setting.error.connect'), second: 5);
      });
    }
    return SizedBox.expand(
      child: PageView(
        controller: controller.pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {},
        children: pages,
      ),
    );
  }
}
