import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/storage/key_constant.dart';
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
            Text(textLocalization('settings.general'), style: text16.medium.textColor141414),
            buildSettingsGeneral(context),
            SizedBox(height: 24.ws),
            Text(textLocalization('settings.social'), style: text16.medium.textColor141414),
            buildSettingsSocial(),
            SizedBox(height: 24.ws),
            Text(textLocalization('settings.help'), style: text16.medium.textColor141414),
            buildSettingsHelp(),
            SizedBox(height: 24.ws),
            CustomButton(
              text: textLocalization('settings.remove.ads'),
              textStyle: text16.medium.textColorWhite,
              onPressed: () => {},
              width: double.infinity,
              height: 42.ws,
              background: colorFF6F15,
              radius: 16.rs,
              isEnable: true,
            ),
            SizedBox(height: 8.ws),
            buildSettingsRestorePurchases(),
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
                    Text(textLocalization('settings.block.ads'), style: text16.textColor141414),
                    Text(
                      textLocalization('settings.ads.name'),
                      style: text16.textColorB2B2B2,
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
                    Text(textLocalization('settings.plugin.title'), style: text16.textColor141414),
                    Text(
                      textLocalization('settings.plugin.content'),
                      style: text16.textColorB2B2B2,
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
              Expanded(child: Text(textLocalization('settings.notification'), style: text16.textColor141414)),
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
