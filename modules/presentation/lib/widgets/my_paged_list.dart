import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:presentation/application/app.dart';
import 'package:presentation/widgets/my_loading.dart';

class MyPagingController<T> extends PagingController<int, T> {
  MyPagingController({super.firstPageKey = 1}) : super.fromValue(const PagingState(nextPageKey: -1));
}

class MyPagedList<T> extends HookWidget {
  const MyPagedList({
    required this.pagingController,
    required this.itemBuilder,
    required this.onLoadMore,
    this.noItemsFoundIndicatorBuilder,
    this.padding,
    super.key,
  });

  final MyPagingController<T> pagingController;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final ValueChanged<int> onLoadMore;
  final Widget Function(BuildContext)? noItemsFoundIndicatorBuilder;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        void listener(int page) {
          if (page != 1) {
            onLoadMore(page);
          }
        }

        pagingController.addPageRequestListener(listener);
        return () => pagingController.removePageRequestListener(listener);
      },
      [pagingController],
    );

    if (pagingController.nextPageKey != null && pagingController.nextPageKey! < 0) {
      return const SizedBox.shrink();
    }

    return PagedListView<int, T>.separated(
      pagingController: pagingController,
      padding: padding,
      separatorBuilder: (_, __) => Gap.xLarge,
      builderDelegate: PagedChildBuilderDelegate(
        firstPageProgressIndicatorBuilder: (_) => const Center(child: MyLoading()),
        newPageProgressIndicatorBuilder: (_) => const Column(
          children: [
            Gap.xLarge,
            MyLoading(),
          ],
        ),
        noItemsFoundIndicatorBuilder: noItemsFoundIndicatorBuilder,
        itemBuilder: (context, item, index) => itemBuilder(context, item, index),
      ),
    );
  }
}
