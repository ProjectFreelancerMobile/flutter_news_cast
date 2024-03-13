import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/storage/key_constant.dart';
import '../../../res/theme/theme_service.dart';
import '../../base/base_page.dart';
import '../../widgets/button/custom_button.dart';
import '../../widgets/default_appbar.dart';
import 'settings_controller.dart';
import 'widget/settings_item_view.dart';

//ignore: must_be_immutable
class SettingsPage extends BasePage<SettingsController> {
  @override
  Widget buildContentView(BuildContext context, SettingsController controller) {
    return ScaffoldBase(
      appBar: DefaultAppbar(title: textLocalization('settings.title'), appBarStyle: AppBarStyle.NONE),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(textLocalization('settings.general'), style: text14.medium.textColor141414),
            buildSettingsGeneral(context),
            SizedBox(height: 24.ws),
            Text(textLocalization('settings.social'), style: text14.medium.textColor141414),
            buildSettingsSocial(),
            SizedBox(height: 24.ws),
            Text(textLocalization('settings.help'), style: text14.medium.textColor141414),
            buildSettingsHelp(),
            SizedBox(height: 24.ws),
            CustomButton(
              text: textLocalization('settings.remove.ads'),
              textStyle: text12.medium.textColorWhite,
              onPressed: () => {},
              width: double.infinity,
              height: 42.ws,
              background: colorFF6F15,
              radius: 16.rs,
              isEnable: true,
            ),
            SizedBox(height: 8.ws),
            buildSettingsRestorePurchases(),
            /*Padding(
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
            ),*/
          ],
        ),
      ),
    );
  }

  final MaterialStateProperty<Color?> trackColor = MaterialStateProperty.resolveWith(
    (final Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return colorSwitch;
      }
      if (states.contains(MaterialState.disabled)) {
        return colorWhite;
      }
      return colorWhite;
    },
  );

  final MaterialStateProperty<Color?> thumbColor = MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      // Material color when switch is selected.
      if (states.contains(MaterialState.selected)) {
        return colorFF6F15;
      }
      // Material color when switch is disabled.
      if (states.contains(MaterialState.disabled)) {
        return colorWhite;
      }
      // Otherwise return null to set default material color
      // for remaining states such as when the switch is
      // hovered, or focused.
      return colorWhite;
    },
  );

  Widget buildSettingsGeneral(BuildContext context) => Column(
        children: [
          SizedBox(height: 8.ws),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(textLocalization('settings.block.ads'), style: text12.textColor141414),
                    Text(
                      textLocalization('settings.ads.name'),
                      style: text12.textColorB2B2B2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              buildSwitch(context, SWITCH_TYPE.BLOCK_ADS),
            ],
          ),
          SizedBox(height: 8.ws),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(textLocalization('settings.plugin.title'), style: text12.textColor141414),
                    Text(
                      textLocalization('settings.plugin.content'),
                      style: text12.textColorB2B2B2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              buildSwitch(context, SWITCH_TYPE.PLUGIN),
            ],
          ),
          Row(
            children: [
              Expanded(child: Text(textLocalization('settings.notification'), style: text12.textColor141414)),
              buildSwitch(context, SWITCH_TYPE.NOTI),
            ],
          ),
          AccountItemView(
            title: textLocalization('settings.rate'),
            onPressed: () {
              _launchStore();
            },
          ),
        ],
      );

  Widget buildSettingsSocial() => Column(
        children: [
          AccountItemView(
            title: textLocalization('settings.share'),
            onPressed: () {
              Share.share(getLinkApp());
            },
          ),
          AccountItemView(
            title: textLocalization('settings.follow.facebook'),
            onPressed: () {
              _launchUrl(Uri.parse('https://facebook.com'));
            },
          ),
          AccountItemView(
            title: textLocalization('settings.follow.telegram'),
            onPressed: () {
              _launchUrl(Uri.parse('https://www.telegram.com'));
            },
          ),
          AccountItemView(
            title: textLocalization('settings.follow.tiktok'),
            onPressed: () {
              _launchUrl(Uri.parse('https://tiktok.com'));
            },
          ),
        ],
      );

  Widget buildSettingsHelp() => Column(
        children: [
          AccountItemView(
            title: textLocalization('settings.update'),
            titleRight: controller.appVersion.value,
            onPressed: () {
              _launchStore();
            },
          ),
        ],
      );

  Widget buildSettingsRestorePurchases() => AccountItemView(
        title: textLocalization('settings.restore.ads'),
        onPressed: () => {},
      );

  Widget buildSwitch(BuildContext context, SWITCH_TYPE switch_type) {
    return Theme(
      data: ThemeData(
        useMaterial3: true,
      ).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(outline: colorSwitch),
      ),
      child: Switch(
        activeTrackColor: colorSwitch,
        inactiveTrackColor: colorSwitch,
        activeColor: colorFF6F15,
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return colorFF6F15;
            }
            if (states.contains(MaterialState.disabled)) {
              return colorWhite;
            }
            return colorWhite;
          },
        ),
        value: controller.getStateSwitch(switch_type),
        onChanged: (bool value) {
          controller.updateStateSwitch(switch_type, value);
        },
      ),
    );
  }

  /* buildSettingsAccount(BuildContext context) {
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
                  onPressed: () => controller.onGotoSecurityPage(),
                ),
                Divider(height: 1, thickness: 0.5, color: color929394),
              ],
            ),
          ),
          AccountItemView(
            title: textLocalization('settings_name'),
            titleRight: controller.user.name,
            onPressed: () => buildOpenUserName(context),
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          // AccountItemView(
          //   title: textLocalization('settings_sex'),
          //   titleRight: controller.user.gender == SEX_TYPE.MEN.name
          //       ? textLocalization('common_men')
          //       : (controller.user.gender == SEX_TYPE.WOMAN.name ? textLocalization('common_women') : textLocalization('common_other')),
          //
          //   onPressed: () => openSexBottomSheet(context),
          // ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_birthday'),
            titleRight: formatDate(controller.user.birthday, DATE_FORMAT),
            onPressed: () => _showDatePicker(context, controller),
          ),
          Divider(height: 1, thickness: 0.5, color: color929394),
          AccountItemView(
            title: textLocalization('settings_phone'),
            titleRight: controller.user.phone,
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
          onPressed: () => controller.onGotoNotificationsSettingPage(),
        ),
      );
*/
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

  /*buildOpenUserName(BuildContext context) => AppDialog(
        context: context,
        title: '',
        description: textLocalization('settings_edit_name'),
        type: DialogType.TWO_ACTION,
        cancelText: textLocalization('dialog.ignore'),
        okText: textLocalization('dialog.save'),
        */ /* input: TextInputLineBorder(
          width: double.infinity,
          hint: 'Nguyễn Văn An',
          hintTextStyle: text12.textColorB2B2B2,
          textTextStyle: text14.textColor141414,
          height: 36.hs,
          textEditingController: controller.txtNameController,
        ),*/ /*
        onOkPressed: () => controller.updateProfile((error) {
          showMessage(error);
        }, userName: controller.txtNameController.text),
      ).show();

  buildOpenPhone(BuildContext context) => AppDialog(
        context: context,
        title: '',
        description: textLocalization('setting.phone.title'),
        type: DialogType.TWO_ACTION,
        cancelText: textLocalization('dialog.ignore'),
        okText: textLocalization('dialog.save'),
        */ /*input: TextInputLineBorder(
          width: double.infinity,
          hint: '0333332093',
          keyboardType: TextInputType.phone,
          hintTextStyle: text12.textColorB2B2B2,
          textTextStyle: text14.textColor141414,
          height: 36.hs,
          textEditingController: controller.txtPhoneController,
        ),*/ /*
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
*/
  void _launchStore() {
    launchUrl(
      Uri.parse(getLinkApp()),
      mode: LaunchMode.externalApplication,
    );
  }

  String getLinkApp() {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.fedoapp.app' : '12345678';
      final url = Platform.isAndroid ? "market://details?id=$appId" : "https://apps.apple.com/app/id$appId";
      return url;
    }
    return '';
  }

  Future<void> _launchUrl(Uri _url) async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url, webViewConfiguration: WebViewConfiguration(enableJavaScript: true));
    } else {
      throw 'Could not launch $_url';
    }
  }
}
