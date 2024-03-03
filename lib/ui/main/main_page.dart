import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import '../../ui/base/base_page.dart';
import '../../ui/main/main_controller.dart';
import '../../ui/widgets/menu/custom_bottom_menu.dart';
import 'home/home_page.dart';
import 'settings/settings_page.dart';

//ignore: must_be_immutable
class MainPage extends BasePage<MainController> {
  //final List<Widget> pages = [HomePage(), ServicePage(), SettingsPage()];
  final List<Widget> pages = [HomePage(), SettingsPage()];

  @override
  Widget buildContentView(BuildContext context, MainController controller) {
    initToast(context);
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        label: 'Menu',
        icon: Assets.icons.icTabHome.svg(),
        activeIcon: Column(
          children: [
            Assets.icons.icTabHomeActive.svg(),
            SizedBox(height: 6.hs),
            Container(
              width: 5.ws,
              height: 5.ws,
              decoration: BoxDecoration(
                color: colorPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
      /* BottomNavigationBarItem(
        label: 'Menu',
        icon: Assets.icons.icTabService.svg(),
        activeIcon: Column(
          children: [
            Assets.icons.icTabServiceActive.svg(),
            SizedBox(height: 6.hs),
            Container(
              width: 5.ws,
              height: 5.ws,
              decoration: BoxDecoration(
                color: colorPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),*/
      BottomNavigationBarItem(
        label: 'Menu',
        icon: Assets.icons.icTabRooms.svg(),
        activeIcon: Column(
          children: [
            Assets.icons.icTabRoomsActive.svg(),
            SizedBox(height: 6.hs),
            Container(
              width: 5.ws,
              height: 5.ws,
              decoration: BoxDecoration(
                color: colorPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    ];
    return Scaffold(
      body: buildPage(context),
      bottomNavigationBar: CustomBottomNenu(
        index: controller.pageIndex.value,
        items: items,
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
