import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/utils/toast_util.dart';

import '../../utils/local_notification_manager.dart';
import '../base/base_page.dart';
import '../payment/widget/button_next.dart';
import '../widgets/default_appbar.dart';
import '../widgets/input/text_form_field_widget.dart';
import 'add_user_controller.dart';

//ignore: must_be_immutable
class AddBillPage extends BasePage<AddUserController> {
  @override
  Widget buildContentView(BuildContext context, AddUserController controller) {
    return ScaffoldBase(
      appBar: DefaultAppbar(color: colorPrimary, title: 'Thêm tiền', appBarStyle: AppBarStyle.BACK),
      body: buildInfoTransfer(),
    );
  }

  buildInfoTransfer() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text('Số tiền', style: text14.medium.textColorTextGrey),
          DTextFromField(
            rightTitle: 'VND',
            hintText: 'Số tiền',
            rightTitleStyle: text16.bold.textColorPrimary,
            keyboardType: TextInputType.number,
            controller: controller.textPriceCl,
            strokeColor: colorBgGrey,
            textStyle: text16.semiBold.textColorBlack,
            onChange: (value) {
              controller.onUpdateMoney(value);
            },
            inputFormatters: [ThousandsFormatter()],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(controller.moneyText.value, style: text14.textColorTextGrey),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nội dung chuyển tiền', style: text14.medium.textColorTextGrey),
              Text('${controller.textNoteCl.text.length}/150', style: text14.medium.textColorTextGrey),
            ],
          ),
          DTextFromField(
            hintText: 'Nội dung chuyển tiền',
            keyboardType: TextInputType.text,
            maxLines: 1,
            controller: controller.textNoteCl,
            strokeColor: colorBgGrey,
            textStyle: text16.semiBold.textColorBlack,
          ),
          SizedBox(height: 20.ws),
          ButtonNext(
            title: 'Thêm',
            onPress: () {
              controller.paymentAddBill((isError, message) {
                showMessage(message, isError: isError);
                if (!isError) {
                  showNotification(controller.user.bienDong.lastOrNull, controller.user);
                }
              });
            },
          ),
        ],
      );
}
