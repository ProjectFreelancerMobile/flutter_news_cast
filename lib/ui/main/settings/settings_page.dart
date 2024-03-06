import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:flutter_news_cast/data/api/api_constants.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/app_controller.dart';
import '../../../data/storage/key_constant.dart';
import '../../../res/theme/theme_service.dart';
import '../../../utils/date_time_utils.dart';
import '../../base/base_page.dart';
import '../../widgets/button/touchable_opacity.dart';
import '../../widgets/default_appbar.dart';
import '../../widgets/dialogs/app_dialog.dart';
import '../../widgets/input/text_input_line_border.dart';
import 'settings_controller.dart';
import 'widget/settings_item_view.dart';

//ignore: must_be_immutable
class SettingsPage extends BasePage<SettingsController> {
  @override
  Widget buildContentView(BuildContext context, SettingsController controller) {
    return Scaffold(
      appBar: DefaultAppbar(title: textLocalization('settings_title'), appBarStyle: AppBarStyle.NONE),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.ws, vertical: 15.hs),
              child: Text(textLocalization('settings_account'), style: text14.textColorB2B2B2),
            ),
            buildSettingsAccount(context),
            Visibility(
              visible: false,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.ws, vertical: 15.hs),
                    child: Text(textLocalization('settings_title'), style: text14.textColorB2B2B2),
                  ),
                  buildSettingsConfig(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 26.ws, vertical: 15.hs),
              child: Text(textLocalization('settings_support'), style: text14.textColorB2B2B2),
            ),
            buildSupport(),
            SizedBox(height: 30.hs),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 26.ws),
              color: getColor().themeColorWhite,
              child: Center(
                child: TextButton(
                  child: Text(textLocalization('logout.title'), style: text14.bold.textColorF20606),
                  onPressed: () {
                    Get.find<AppController>().logout();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingsAccount(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.ws),
      color: getColor().themeColorWhite,
      child: Column(
        children: [
          Visibility(
            visible: false,
            child: Column(
              children: [
                AccountItemView(
                  title: textLocalization('settings_account_security'),
                  isIconNext: true,
                  onPressed: () => controller.onGotoSecurityPage(),
                ),
                Divider(height: 1, thickness: 0.5, color: color929394),
              ],
            ),
          ),
          AccountItemView(
            title: textLocalization('settings_name'),
            titleRight: controller.user.name,
            isIconNext: true,
            onPressed: () => buildOpenUserName(context),
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          // AccountItemView(
          //   title: textLocalization('settings_sex'),
          //   titleRight: controller.user.gender == SEX_TYPE.MEN.name
          //       ? textLocalization('common_men')
          //       : (controller.user.gender == SEX_TYPE.WOMAN.name ? textLocalization('common_women') : textLocalization('common_other')),
          //   isIconNext: true,
          //   onPressed: () => openSexBottomSheet(context),
          // ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_birthday'),
            titleRight: formatDate(controller.user.birthday, DATE_FORMAT),
            isIconNext: true,
            onPressed: () => _showDatePicker(context, controller),
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_phone'),
            titleRight: controller.user.phone,
            isIconNext: true,
            onPressed: () => buildOpenPhone(context),
          ),
        ],
      ),
    );
  }

  Widget buildSettingsConfig() => Container(
        height: 54.ws,
        color: getColor().themeColorWhite,
        padding: EdgeInsets.symmetric(horizontal: 26.ws),
        child: AccountItemView(
          title: textLocalization('settings_noti'),
          isIconNext: true,
          onPressed: () => controller.onGotoNotificationsSettingPage(),
        ),
      );

  Widget buildSupport() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 26.ws),
      color: getColor().themeColorWhite,
      child: Column(
        children: [
          AccountItemView(
            title: textLocalization('settings_check_update'),
            titleRight: controller.appVersion.value,
            onPressed: () {
              _launchStore();
            },
          ),
          /*Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_help'),
            onPressed: () {},
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_error'),
            onPressed: () {},
          ),*/
          Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_vote'),
            onPressed: () {
              _launchStore();
            },
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_about'),
            onPressed: () {
              _launchUrl(Uri.parse('https://urvega.com'));
            },
          ),
        ],
      ),
    );
  }

  buildOpenUserName(BuildContext context) => AppDialog(
        context: context,
        title: '',
        description: textLocalization('settings_edit_name'),
        type: DialogType.INPUT,
        cancelText: textLocalization('dialog.ignore'),
        okText: textLocalization('dialog.save'),
        input: TextInputLineBorder(
          width: double.infinity,
          hint: 'Nguyễn Văn An',
          hintTextStyle: text12.textColorB2B2B2,
          textTextStyle: text14.textColor141414,
          height: 36.hs,
          textEditingController: controller.txtNameController,
        ),
        onOkPressed: () => controller.updateProfile((error) {
          showMessage(error);
        }, userName: controller.txtNameController.text),
      ).show();

  buildOpenPhone(BuildContext context) => AppDialog(
        context: context,
        title: '',
        description: textLocalization('setting.phone.title'),
        type: DialogType.INPUT,
        cancelText: textLocalization('dialog.ignore'),
        okText: textLocalization('dialog.save'),
        input: TextInputLineBorder(
          width: double.infinity,
          hint: '0333332093',
          keyboardType: TextInputType.phone,
          hintTextStyle: text12.textColorB2B2B2,
          textTextStyle: text14.textColor141414,
          height: 36.hs,
          textEditingController: controller.txtPhoneController,
        ),
        onOkPressed: () => controller.updateProfile((error) {
          showMessage(error);
        }, phone: controller.txtPhoneController.text),
      ).show();

  void _showDatePicker(BuildContext context, SettingsController controller) {
    DatePicker.showDatePicker(
      context,
      onMonthChangeStartWithFirstDate: true,
      pickerTheme: DateTimePickerTheme(
        showTitle: true,
        confirm: Text(textLocalization('dialog.confirm'), style: text16.bold.textColorPrimary),
      ),
      minDateTime: DateTime.parse(MIN_DATETIME),
      maxDateTime: DateTime.parse(MAX_DATETIME),
      initialDateTime: controller.dateTime,
      dateFormat: DATE_FORMAT3,
      locale: controller.locale!,
      onClose: () => print("----- onClose -----"),
      onCancel: () => print('onCancel'),
      onConfirm: (dateTime, List<int> index) {
        controller.updateProfile((error) {
          showMessage(error);
        }, birthday: dateTime);
      },
    );
  }

  void openSexBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20.hs),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 12.hs),
            child: Text(
              textLocalization('settings_sex'),
              style: text14.bold.textColor141414,
            ),
          ),
          TouchableOpacity(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 12.hs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textLocalization('setting.sex.men'),
                    style: text14.textColor141414,
                  ),
                  controller.sexType.value == SEX_TYPE.MEN ? Icon(Icons.check, size: 16) : SizedBox()
                ],
              ),
            ),
            onPressed: () => controller.updateProfile(
              (error) {
                showMessage(error);
              },
              sexType: SEX_TYPE.MEN,
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          TouchableOpacity(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 12.hs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textLocalization('setting.sex.woman'),
                    style: text14.textColor141414,
                  ),
                  controller.sexType.value == SEX_TYPE.WOMAN ? Icon(Icons.check, size: 16) : SizedBox()
                ],
              ),
            ),
            onPressed: () => controller.updateProfile(
              (error) {
                showMessage(error);
              },
              sexType: SEX_TYPE.WOMAN,
            ),
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          TouchableOpacity(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 12.hs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textLocalization('setting.sex.other'),
                    style: text14.textColor141414,
                  ),
                  controller.sexType.value == SEX_TYPE.OTHER ? Icon(Icons.check, size: 16) : SizedBox()
                ],
              ),
            ),
            onPressed: () => controller.updateProfile(
              (error) {
                showMessage(error);
              },
              sexType: SEX_TYPE.OTHER,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
      backgroundColor: colorWhite,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
    );
  }

  void _launchStore() {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.urvega.app' : '12345678';
      final url = Uri.parse(
        Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId",
      );
      launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _launchUrl(Uri _url) async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, webViewConfiguration: WebViewConfiguration(enableJavaScript: true));
    } else {
      throw 'Could not launch $_url';
    }
  }
}
