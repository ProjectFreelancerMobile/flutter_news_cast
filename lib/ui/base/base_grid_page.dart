import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../res/colors.dart';
import '../../res/theme/theme_service.dart';
import '../../ui/base/base_grid_controller.dart';
import '../../ui/widgets/data_empty_widget.dart';
import '../../ui/widgets/loading_widget.dart';
import 'base_page.dart';

//ignore: must_be_immutable
abstract class BaseGridPage<I, C extends BaseGridController<I>> extends BasePage<C> {
  EdgeInsets get padding => const EdgeInsets.all(0);

  double get itemSpacing => 0;

  Color get dividerColor => colorWhite;
  int crossAxisCount = 2;

  double childAspectRatio = 1;

  double mainAxisSpacing = 0;

  double crossAxisSpacing = 0;

  bool get shrinkWrap => false;

  Axis get axis => Axis.vertical;

  ScrollPhysics get scrollPhysics => AlwaysScrollableScrollPhysics();
  double gridMarginHorizontal = 0;

  EdgeInsets get paddingGrid => EdgeInsets.symmetric(horizontal: gridMarginHorizontal);

  Color get background => getColor().bgThemeColorWhite;

  Widget buildItem(BuildContext context, I item, int index);

  @override
  Widget buildContentView(BuildContext context, C controller) {
    return Container(
        color: background,
        child: (controller.items.isNotEmpty || controller.viewState.value == ViewState.loading)
            ? CustomScrollView(
                physics: BouncingScrollPhysics(),
                controller: controller.scrollController,
                slivers: [
                  CupertinoSliverRefreshControl(
                    onRefresh: controller.enableRefresh ? controller.onRrefresh : null,
                    builder: (_, __, a1, a2, a3) {
                      return Container(
                        alignment: Alignment.center,
                        child: LoadingWidget(
                          radius: 12,
                        ),
                      );
                    },
                  ),
                  SliverPadding(
                      padding: padding,
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspectRatio,
                          mainAxisSpacing: mainAxisSpacing,
                          crossAxisSpacing: crossAxisSpacing,
                        ),
                        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                          return buildItem(context, controller.items[index], index);
                        }, childCount: controller.items.length),
                      )),
                  SliverToBoxAdapter(
                      child: Obx(
                    () => controller.isLoadMore.value
                        ? Container(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            alignment: Alignment.center,
                            child: LoadingWidget(
                              radius: 16,
                            ),
                          )
                        : SizedBox(),
                  )),
                ],
              )
            : DataEmptyWidget());
  }

  jumpToTop() {
    controller.scrollController.animateTo(
      0.0,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
