import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui/widgets/data_error_widget.dart';
import '../../ui/widgets/loading_widget.dart';
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
    return Center(
      child: LoadingWidget(
        radius: 16,
      ),
    );
  }

  Widget buildContentView(BuildContext context, C controller);

  Widget get buildLoadingView => buildDefaultLoading();
}

enum ViewState { initial, loading, loaded, error }
