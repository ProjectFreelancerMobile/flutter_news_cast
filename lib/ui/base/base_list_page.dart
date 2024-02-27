import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../res/style.dart';
import '../../res/theme/theme_service.dart';
import '../../ui/base/base_list_controller.dart';
import '../../ui/base/base_page.dart';
import '../../ui/widgets/data_empty_widget.dart';
import '../../ui/widgets/loading_widget.dart';

//ignore: must_be_immutable
abstract class BaseListPage<I, C extends BaseListController<I>> extends BasePage<C> {
  EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: 0, vertical: 0);

  double get itemSpacing => 0;

  Color get dividerColor => colorWhite;

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
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Column(
                            children: [buildItem(context, controller.items[index], index), Divider(height: itemSpacing, color: dividerColor)],
                          );
                        },
                        childCount: controller.items.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: controller.isLoadMore.value
                        ? Container(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            alignment: Alignment.center,
                            child: LoadingWidget(
                              radius: 12,
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              )
            : DataEmptyWidget(
                background: background,
              ));
  }
}
