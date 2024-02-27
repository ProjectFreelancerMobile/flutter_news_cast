import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_news_cast/res/gen/assets.gen.dart';

import '../../ui/widgets/data_error_widget.dart';
import 'base_controller.dart';

//ignore: must_be_immutable
abstract class BasePage<C extends BaseController> extends GetWidget<C> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => buildViewState(context));
  }

  Widget buildViewState(BuildContext context) {
    switch (controller.viewState.value) {
      case ViewState.error:
        return DataErrorWidget(
          messageError: controller.errorMessage,
          onReloadData: controller.onReloadData,
        );
      case ViewState.loaded:
      case ViewState.loading:
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: controller.viewState.value == ViewState.loading,
              child: buildContentView(context, controller),
            ),
            if (controller.viewState.value == ViewState.loading) buildLoadingView,
          ],
        );
      default:
        return buildContentView(context, controller);
    }
  }

  Widget buildDefaultLoading() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black45,
      child: Center(
        child: IgnorePointer(child: Lottie.asset(Assets.json.loading)),
      ),
    );
  }

  Widget buildContentView(BuildContext context, C controller);

  Widget get buildLoadingView => buildDefaultLoading();
}

enum ViewState { initial, loading, loaded, error }
