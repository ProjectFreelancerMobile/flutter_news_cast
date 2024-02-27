import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../utils/toast_util.dart';
import '../base/base_page.dart';
import '../widgets/base_scaffold_widget.dart';
import '../widgets/button/custom_button.dart';
import '../widgets/default_appbar.dart';
import '../widgets/input/text_form_field_widget.dart';
import 'login_controller.dart';

//ignore: must_be_immutable
class LoginUserPage extends BasePage<LoginController> {
  @override
  Widget buildContentView(BuildContext context, LoginController controller) {
    return ScaffoldBase(
      resizeToAvoidBottomInset: false,
      imageBackground: controller.themeMain(),
      appBar: DefaultAppbar(
        appBarStyle: AppBarStyle.BACK,
        isIconBank: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.only(bottom: 32.ws),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 60.ws),
                    Text('Đăng nhập vào iPay', style: text26.bold.textColorWhite),
                    SizedBox(height: 30.ws),
                    DTextFromField(
                      suffixIcon: Assets.icons.login.icInfo.svg(),
                      hintText: 'Tên đăng nhập',
                      keyboardType: TextInputType.text,
                      controller: controller.textUserNameCl,
                      strokeColor: colorEBEBEC,
                      textHintStyle: text20.semiBold.textColorMainLight,
                      textStyle: text20.semiBold.textColorWhite,
                      onValidated: (val) {
                        return controller.validatorEmail();
                      },
                    ),
                    SizedBox(height: 6.ws),
                    Align(alignment: Alignment.centerRight, child: Text('Quên tên đăng nhập?', style: text15.semiBold.textColorMainMedium, textAlign: TextAlign.end)),
                    SizedBox(height: 18.ws),
                    DTextFromField(
                      suffixIcon: Assets.icons.login.icEyes.svg(),
                      hintText: 'Mật khẩu',
                      keyboardType: TextInputType.visiblePassword,
                      controller: controller.textPasswordCl,
                      strokeColor: colorEBEBEC,
                      obscureText: true,
                      textStyle: text20.semiBold.textColorWhite,
                      textHintStyle: text20.semiBold.textColorMainLight,
                      onValidated: (val) {
                        return controller.passwordValidator();
                      },
                    ),
                    SizedBox(height: 6.ws),
                    Align(alignment: Alignment.centerRight, child: Text('Quên mật khẩu?', style: text15.semiBold.textColorMainMedium)),
                    SizedBox(height: 24.ws),
                    CustomButton(
                      text: 'Đăng nhập',
                      onPressed: () {
                        controller.loginUser((error) {
                          showMessage(error);
                        });
                      },
                      isEnable: true,
                      width: double.infinity,
                      textStyle: text16.semiBold.textColorMainDark,
                    ),
                    SizedBox(height: 24.ws),
                    CustomButton(
                      text: 'Chưa có tên đăng nhập/mật khẩu',
                      onPressed: () {},
                      isEnable: true,
                      background: colorTransparent80,
                      width: double.infinity,
                      textStyle: text16.semiBold.textColorWhite,
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.rs),
                      color: colorTransparent80,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 24.ws),
                        Text('Bạn cần hỗ trợ?', style: text15.semiBold.textColorWhite),
                        SizedBox(width: 16.ws),
                        Container(
                          width: 56.ws,
                          height: 56.ws,
                          padding: EdgeInsets.all(10.ws),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorBackground,
                          ),
                          child: Assets.icons.login.icCall.svg(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
