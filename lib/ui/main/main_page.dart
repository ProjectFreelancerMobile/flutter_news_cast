import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/settings/settings_page.dart';

import '../../ui/base/base_page.dart';
import '../../ui/main/main_controller.dart';
import '../notification/list_notification_page.dart';
import 'home/home_page.dart';

//ignore: must_be_immutable
class MainPage extends BasePage<MainController> {
  final List<Widget> pages = [HomePage(), ListNotificationPage(), SizedBox(), SizedBox(), SettingsPage()];

  @override
  Widget buildContentView(BuildContext context, MainController controller) {
    final List<Widget> iconList = [
      Assets.icons.menu.icMenuHome.svg(height: 20.ws),
      Assets.icons.menu.icMenuNoti.svg(height: 20.ws),
      Assets.icons.menu.icMenuShop.svg(height: 20.ws),
      Assets.icons.menu.icMenuTrade.svg(height: 20.ws),
      Assets.icons.menu.icMenuProfile.svg(height: 20.ws),
    ];
    final List<Widget> iconListActive = [
      Assets.icons.menu.icMenuHomeActive.svg(height: 20.ws),
      Assets.icons.menu.icMenuNotiActive.svg(height: 20.ws),
      Assets.icons.menu.icMenuShop.svg(height: 20.ws),
      Assets.icons.menu.icMenuTrade.svg(height: 20.ws),
      Assets.icons.menu.icMenuProfileActive.svg(height: 20.ws),
    ];
    return Scaffold(
      body: buildPage(context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        currentIndex: controller.pageIndex.value,
        items: [
          BottomNavigationBarItem(
            icon: controller.pageIndex.value == 0 ? iconListActive[0] : iconList[0],
            label: '',
          ),
          BottomNavigationBarItem(
            icon: controller.pageIndex.value == 1 ? iconListActive[1] : iconList[1],
            label: '',
          ),
          BottomNavigationBarItem(
            icon: controller.pageIndex.value == 2 ? iconListActive[2] : iconList[2],
            label: '',
          ),
          BottomNavigationBarItem(
            icon: controller.pageIndex.value == 3 ? iconListActive[3] : iconList[3],
            label: '',
          ),
          BottomNavigationBarItem(
            icon: controller.pageIndex.value == 4 ? iconListActive[4] : iconList[4],
            label: '',
          ),
        ],
        onTap: (int index) {
          buildWidgetDialogCheckLogin(
            (isLogin) {
              if (isLogin && (index != 2 && index != 3)) {
                controller.onTabChanged(index);
              }
            },
          );
        },
      ),
    );
  }

  buildPage(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: PageView(
            controller: controller.pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (index) {},
            children: pages,
          ),
        ),
      ],
    );
  }

  buildWidgetDialogCheckLogin(Function(bool) checkLogin) {
    if (controller.checkLogin) {
      checkLogin(true);
    } else {
      checkLogin(false);
    }
  }
}
