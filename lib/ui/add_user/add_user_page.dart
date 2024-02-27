import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/utils/toast_util.dart';

import '../base/base_page.dart';
import '../payment/widget/button_next.dart';
import '../widgets/button/touchable_opacity.dart';
import '../widgets/default_appbar.dart';
import '../widgets/input/text_form_field_widget.dart';
import 'add_user_controller.dart';

//ignore: must_be_immutable
class AddUserPage extends BasePage<AddUserController> {
  @override
  Widget buildContentView(BuildContext context, AddUserController controller) {
    return ScaffoldBase(
      appBar: DefaultAppbar(color: colorPrimary, title: 'Chỉnh sửa', appBarStyle: AppBarStyle.BACK),
      body: Column(
        children: [
          DTextFromField(
            suffixIcon: Assets.icons.payment.icPaymentPerson.svg(),
            hintText: 'Tên người thụ hưởng',
            keyboardType: TextInputType.text,
            controller: controller.txtNameController,
            alignLabelWithHint: true,
            strokeColor: colorRed20,
            contentPadding: EdgeInsets.symmetric(vertical: 10.ws),
            textStyle: text16.medium.textColorBlack,
            onValidated: (val) {
              return null;
            },
          ),
          SizedBox(height: 20.ws),
          ButtonNext(
            title: 'Thêm',
            onPress: () {
              controller.paymentAddTKCT((isError, message) {
                showMessage(message, isError: isError);
              });
            },
          ),
          Expanded(
            child: controller.lenghtIndex.value > 0
                ? ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 0.5,
                      color: colorBgGrey,
                    ),
                    itemBuilder: (context, index) {
                      final item = controller.listUser[index];
                      return SizedBox(
                        height: 42.ws,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(item, style: text16.semiBold.textColorBlack),
                            Row(
                              children: [
                                TouchableOpacity(
                                  child: Icon(Icons.edit),
                                  onPressed: () {
                                    controller.onUpdateEditUser(item);
                                    Get.defaultDialog(
                                        backgroundColor: Colors.white,
                                        buttonColor: colorPrimary,
                                        contentPadding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 12.ws),
                                        title: 'Sửa',
                                        content: SizedBox(
                                          width: Get.width - 10.ws,
                                          child: DTextFromField(
                                            suffixIcon: Assets.icons.payment.icPaymentPerson.svg(),
                                            hintText: 'Tên người thụ hưởng',
                                            keyboardType: TextInputType.text,
                                            controller: controller.txtNameEditController,
                                            alignLabelWithHint: true,
                                            strokeColor: colorRed20,
                                            contentPadding: EdgeInsets.symmetric(horizontal: 16.ws),
                                            textStyle: text16.medium.textColorBlack,
                                            onValidated: (val) {
                                              return null;
                                            },
                                          ),
                                        ),
                                        textCancel: '         Huỷ         ',
                                        textConfirm: '       Đồng ý       ',
                                        onCancel: () {},
                                        onConfirm: () {
                                          Get.back();
                                          controller.paymentEditTKCT(index, (isError, message) {
                                            showMessage(message, isError: isError);
                                          });
                                        });
                                  },
                                ),
                                SizedBox(width: 10.ws),
                                TouchableOpacity(
                                  child: Icon(Icons.delete),
                                  onPressed: () {
                                    controller.paymentDeleteTKCT(index, (isError, message) {
                                      showMessage(message, isError: isError);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: controller.listUser.length,
                  )
                : SizedBox(),
          ),
        ],
      ),
    );
  }
}
