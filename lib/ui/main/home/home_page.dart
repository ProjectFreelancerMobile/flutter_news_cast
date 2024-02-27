import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

import '../../../app/app_pages.dart';
import '../../../utils/toast_util.dart';
import '../../base/base_page.dart';
import '../../widgets/animation/ExpandedSection.dart';
import '../../widgets/base_scaffold_widget.dart';
import '../../widgets/icon_text/icons_component.dart';
import 'home_controller.dart';

//ignore: must_be_immutable
class HomePage extends BasePage<HomeController> {
  final listKm = [
    Assets.images.home.icKmBanner1.image(),
    Assets.images.home.icKmBanner2.image(),
    Assets.images.home.icKmBanner3.image(),
    Assets.images.home.icKmBanner4.image(),
    Assets.images.home.icKmBanner5.image(),
    Assets.images.home.icKmBanner6.image(),
    Assets.images.home.icKmBanner7.image(),
    Assets.images.home.icKmBanner8.image(),
    Assets.images.home.icKmBanner9.image(),
  ];

  final listIntro = [
    Assets.images.home.icKmBottomBanner1.image(),
    Assets.images.home.icKmBottomBanner2.image(),
    Assets.images.home.icKmBottomBanner3.image(),
  ];

  @override
  Widget buildContentView(BuildContext context, HomeController controller) {
    initToast(context);
    return ScaffoldBase(
      imageBackground: controller.themeMain(),
      isPadding: false,
      body: Stack(
        children: [
          Column(
            children: [
              controller.showTabBarFull.value
                  ? ExpandedSection(
                      expand: controller.showTabBarFull.value,
                      child: buildUserInfo(),
                    )
                  : buildUserInfoLite(),
              Expanded(
                child: SingleChildScrollView(
                  controller: controller.controller,
                  child: Container(
                    color: colorBackground,
                    child: Column(
                      children: [
                        SizedBox(height: 50.ws),
                        buildWidgetTinhNang(),
                        SizedBox(height: 16.ws),
                        buildWidgetKm(),
                        SizedBox(height: 16.ws),
                        buildWidgetShopping(),
                        SizedBox(height: 16.ws),
                        buildWidgetLogistic(),
                        SizedBox(height: 16.ws),
                        buildWidgetHeatThy(),
                        SizedBox(height: 16.ws),
                        buildWidgetBannerBottom(),
                        SizedBox(height: 32.ws),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          if (controller.showTabBarFull.value) ...[
            Positioned(
              child: Transform.translate(
                offset: Offset(0, 220.ws),
                child: buildWidgetMain(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget buildUserInfo() => Container(
        width: Get.width,
        height: 250.ws,
        padding: EdgeInsets.only(top: 40.ws, bottom: 32.ws, left: 24.ws, right: 24.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TouchableOpacity(
                  onPressed: () => Get.toNamed(AppRoutes.ADD_USER),
                  child: Assets.icons.logo.icTextVietinIpay.svg(height: 18.ws),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colorPrimary, width: 1.ws),
                  ),
                  child: Assets.icons.home.icSearch.svg(width: 20.ws),
                ),
              ],
            ),
            SizedBox(height: 20.ws),
            controller.user.userName.isEmpty
                ? TouchableOpacity(
                    onPressed: () => Get.offAllNamed(AppRoutes.INITIAL),
                    child: SizedBox(
                      width: 200.ws,
                      height: 80.ws,
                      child: Stack(
                        children: [
                          Assets.icons.home.icBgUser.svg(),
                          Positioned(
                            right: 10.ws,
                            top: 0,
                            bottom: 0,
                            child: Center(child: Text('Đăng nhập', style: text13.bold.textColorWhite, textAlign: TextAlign.center)),
                          ),
                        ],
                      ),
                    ),
                  )
                : TouchableOpacity(
                    onPressed: () {
                      controller.onGetBalance();
                      Get.toNamed(AppRoutes.NAV_BALANCE_INFO);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            width: 80.ws,
                            height: 80.ws,
                            decoration: BoxDecoration(
                              color: Color(0xFF4b6477),
                              shape: BoxShape.circle,
                              border: Border.all(color: colorMainLight, width: 2.ws),
                            ),
                            child: Center(child: Text('VT', style: text24.textColorTextGreyLight)),
                          ),
                          SizedBox(width: 12.ws),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(controller.user.displayName ?? '', style: text16.bold.textColorWhite),
                              Text('Khách hàng thân thiết >', style: text13.medium.textColorMainMedium), //controller.updateBalanceMoney.value
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      );

  Widget buildUserInfoLite() => Container(
        width: Get.width,
        height: 160.ws,
        padding: EdgeInsets.symmetric(horizontal: 24.ws),
        child: TouchableOpacity(
          onPressed: () {
            controller.onGetBalance();
            Get.toNamed(AppRoutes.NAV_BALANCE_INFO);
          },
          child: Center(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80.ws,
                    height: 80.ws,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF4b6477),
                      shape: BoxShape.circle,
                      border: Border.all(color: colorMainLight, width: 2.ws),
                    ),
                    child: Center(child: Assets.icons.home.icUserAvatar.svg()),
                  ),
                  Row(
                    children: [
                      Assets.icons.home.icViWhite.svg(height: 32.ws),
                      SizedBox(width: 12.ws),
                      Assets.icons.home.icVisaWhite.svg(height: 32.ws),
                      SizedBox(width: 12.ws),
                      Assets.icons.home.icQrcodeWhite.svg(height: 32.ws),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  buildWidgetMain() => Container(
    margin: EdgeInsets.symmetric(horizontal: 16.ws),
        height: 75.ws,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16.rs)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.ws),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TouchableOpacity(
                child: buildColumnTextImageMain(
                  Assets.icons.home.icVi.svg(),
                  'Tài khoản',
                ),
                onPressed: () {
                  controller.onGetBalance();
                  Get.toNamed(AppRoutes.NAV_BALANCE_INFO);
                },
              ),
              VerticalDivider(),
              buildColumnTextImageMain(
                Assets.icons.home.icVisa.svg(),
                'Dịch vụ thẻ',
              ),
              VerticalDivider(),
              TouchableOpacity(
                child: buildColumnTextImageMain(
                  Assets.icons.home.icQrcode.svg(),
                  'QR Pay',
                ),
                onPressed: () {
                  controller.resetPayment();
                  Get.toNamed(AppRoutes.QRCODE);
                },
              ),
            ],
          ),
        ),
      );

  buildWidgetTinhNang() => buildWidgetContainer(
        'Tính năng',
    [
          TouchableOpacity(
            onPressed: () {
              controller.resetPayment();
              Get.toNamed(AppRoutes.PAYMENT_WELCOME);
            },
            child: buildColumnTextImageMenu(
              Assets.icons.home.icTinhnang1.svg(),
              'Chuyển &\nnhận tiền',
            ),
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icTinhnang2.svg(),
            'Thanh toán\nhoá đơn',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icTinhnang3.svg(),
            'Dịch vụ vay &\ntín dụng',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icTinhnang4.svg(),
            'Dịch vụ \ntiết kiệm',
          ),
        ],
        [
          TouchableOpacity(
            onPressed: () => Get.toNamed(AppRoutes.ADD_BILL),
            child: buildColumnTextImageMenu(
              Assets.icons.home.icTinhnang5.svg(),
              'Nạp tiền\nđiện thoại',
            ),
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icTinhnang6.svg(),
            'Mở thẻ mới\n',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icTinhnang7.svg(),
            'Thuế & phí\ndịch vụ công',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icTinhnang8.svg(),
            'Xác thực\ngiao dịch',
          ),
        ],
      );

  buildWidgetKm() => Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.ws, right: 16.ws, bottom: 12.ws),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ưu đãi & khuyến mãi', style: text16.bold.textColorBlack),
                Text('Xem tất cả', style: text13.bold.textColorMainMedium),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 150.ws,
            padding: EdgeInsets.only(left: 8.ws),
            child: ListView.builder(
              itemCount: listKm.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.ws),
                  child: listKm[index],
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      );

  buildWidgetShopping() => Container(
        width: double.infinity,
        height: 210.ws,
        padding: EdgeInsets.symmetric(horizontal: 16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mua sắm & giải trí', style: text16.bold.textColorBlack),
            SizedBox(height: 8.ws),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    buildColumnTextImageMenu(
                      Assets.icons.home.icShopping1.svg(),
                      'Đặt vé\nsổ xố',
                    ),
                    SizedBox(height: 8.ws),
                    buildColumnTextImageMenu(
                      Assets.icons.home.icShopping3.svg(),
                      'Đặt sân Golf/\nMua đồ Golf',
                    ),
                  ],
                ),
                Column(
                  children: [
                    buildColumnTextImageMenu(
                      Assets.icons.home.icShopping2.svg(),
                      'Mua vé \nxem phim',
                    ),
                    SizedBox(height: 8.ws),
                    buildColumnTextImageMenu(
                      Assets.icons.home.icShopping4.svg(),
                      'Mua sắm\nVnShop',
                    ),
                  ],
                ),
                buildColumnTextImageMenu(
                  Assets.icons.home.icShopping5.svg(),
                  'Đặt vé sự kiện,\nthể thao, khu vui chơi',
                  size: 130.ws,
                ),
              ],
            ),
          ],
        ),
      );

  buildWidgetLogistic() => buildWidgetContainer(
        'Du lịch & vận chuyển',
        [
          buildColumnTextImageMenu(
            Assets.icons.home.icLogistic1.svg(),
            'Đặt vé\nmáy bay',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icLogistic2.svg(),
            'Đặt phòng\nkhách sạn',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icLogistic3.svg(),
            'VNPAY Taxi\n',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icLogistic4.svg(),
            'Đặt vé tàu\n',
          ),
        ],
        [
          buildColumnTextImageMenu(
            Assets.icons.home.icLogistic5.svg(),
            'Đặt vé xe\n',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icLogistic6.svg(),
            'Giao hàng\n',
          ),
          SizedBox(width: 75.ws),
          SizedBox(width: 75.ws),
        ],
      );

  buildWidgetHeatThy() => buildWidgetContainer(
        'Sức khoẻ & đời sống',
        [
          buildColumnTextImageMenu(
            Assets.icons.home.icHearthy1.svg(),
            'Mua bảo\nhiểm',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icHearthy2.svg(),
            'Đặt chỗ tiêm\nvacxin',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icHearthy3.svg(),
            'Mua data\n3G/4G',
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icHearthy4.svg(),
            'Tặng hoa tươi\n',
          ),
        ],
        [
          Transform.translate(
            offset: Offset(-6.ws, 0),
            child: buildColumnTextImageMenu(
              Assets.icons.home.icHearthy5.svg(),
              'Mua gói cước\nVinaphone',
            ),
          ),
          Transform.translate(
            offset: Offset(-6.ws, 0),
            child: buildColumnTextImageMenu(
              Assets.icons.home.icHearthy6.svg(),
              'Mua mã thẻ\n',
            ),
          ),
          buildColumnTextImageMenu(
            Assets.icons.home.icHearthy7.svg(),
            'Bác sĩ gia\nđình',
          ),
          SizedBox(width: 100.ws),
        ],
      );

  buildWidgetBannerBottom() => Container(
        width: Get.width,
        height: 200.ws,
        padding: EdgeInsets.only(left: 16.ws),
        child: PageView.builder(
          itemCount: listIntro.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(right: 16.ws),
              child: listIntro[index],
            );
          },
          scrollDirection: Axis.horizontal,
          controller: controller.controllerIntro,
          padEnds: false,
          onPageChanged: (num) {
            controller.onTabChangedIntro(num);
          },
        ),
      );

  buildWidgetContainer(String title, List<Widget> listTop, List<Widget> listBottom) => Container(
        width: double.infinity,
        height: 210.ws,
        padding: EdgeInsets.symmetric(horizontal: 16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: text16.bold.textColorBlack),
            SizedBox(height: 8.ws),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: listTop),
            SizedBox(height: 8.ws),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: listBottom),
          ],
        ),
      );
}
