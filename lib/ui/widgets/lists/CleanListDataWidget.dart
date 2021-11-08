import 'package:clean/ui/widgets/loaders/LoadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tch_appliable_core/tch_appliable_core.dart';

import '../custom/SliverFillRemainingBoxAdapter.dart';

class CleanListDataWidget<R extends DataRequest, I extends DataModel> extends AbstractDataWidget {
  final ProcessResult<R, I> processResult;
  final ItemBuilder<I> buildItem;
  final BuildLoadingItemWithGlobalKey buildLoadingItemWithGlobalKey;
  final Widget emptyState;
  final Widget? childAfterList;

  /// ListDataWidget initialization
  CleanListDataWidget({
    Key? key,
    required R? dataRequest,
    required this.processResult,
    required this.buildItem,
    required this.buildLoadingItemWithGlobalKey,
    required this.emptyState,
    this.childAfterList,
  }) : super(key: key, dataRequests: <DataRequest>[if (dataRequest != null) dataRequest]);

  /// Create state for widget
  @override
  CleanListDataWidgetState<R, I> createState() => CleanListDataWidgetState<R, I>();
}

class CleanListDataWidgetState<R extends DataRequest, I extends DataModel> extends AbstractDataWidgetState<CleanListDataWidget<R, I>> {
  final ScrollController _scrollController = ScrollController();
  GlobalKey _loadingItemKey = GlobalKey();
  double _loadingItemHeight = 0;
  bool _isLastPage = false;
  List<I> _items = <I>[];
  int _itemsBeforeNextPage = 0;

  /// State initialization
  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_isEndOfList);
  }

  /// Dispose of resources manually
  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  /// Create screen content from widgets
  @override
  Widget buildContent(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => _initLoadingItemHeight());

    final theDataSource = dataSource;
    if (theDataSource == null) {
      return widget.emptyState;
    }

    return ValueListenableBuilder(
      valueListenable: theDataSource.results,
      builder: (BuildContext context, List<DataRequest> dataRequests, Widget? child) {
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) => _isEndOfList());

        final List<Widget> content = <Widget>[];

        final R dataRequest = dataRequests.first as R;

        if (dataRequest.result != null) {
          final List<I>? items = widget.processResult(dataRequest);
          _items = items ?? <I>[];

          if (items?.isNotEmpty == true) {
            content.addAll(
              <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int position) {
                      return widget.buildItem(context, position, _items[position]);
                    },
                    childCount: _items.length,
                  ),
                ),
                if (!_isLastPage) widget.buildLoadingItemWithGlobalKey(context, _loadingItemKey),
              ],
            );
          } else {
            return widget.emptyState;
          }
        } else {
          content.add(widget.buildLoadingItemWithGlobalKey(context, _loadingItemKey));
        }

        final theChildAfterList = widget.childAfterList;
        if (theChildAfterList != null) {
          content.add(theChildAfterList);
        }

        RefreshController controller = RefreshController();

        return RefreshConfiguration(// Maximum dragging range at the bottom
          child: Scrollbar(
            child: SmartRefresher(
              enablePullDown: true,
              controller: controller,
              header: CustomHeader(refreshStyle: RefreshStyle.UnFollow,
                builder: buildHeader,height: 40,),
              onRefresh: () async {
                //todo:implement refresh
                await Future.delayed(Duration(milliseconds: 1000));
                controller.refreshCompleted();
              },
              onLoading: () async {
                //todo:implement refresh
                await Future.delayed(Duration(milliseconds: 1000));
                controller.loadComplete();
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: content,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildHeader(BuildContext context, RefreshStatus? mode) {
    return LoadingWidget(
      size: 23,
    );
  }

  /// Calculate height of LoadingItem
  _initLoadingItemHeight() {
    if (_loadingItemHeight > 0 || _loadingItemKey.currentContext == null) {
      return;
    }

    final RenderSliverFillRemainingBoxAdapter? loadingItemRenderBox =
    _loadingItemKey.currentContext?.findRenderObject() as RenderSliverFillRemainingBoxAdapter?;

    if (loadingItemRenderBox != null) {
      _loadingItemHeight = loadingItemRenderBox.child!.size.height;
    }
  }

  /// Check if is scrolled to the end of list, call next page if yes
  _isEndOfList() {
    if (_scrollController.hasClients) {
      final double maxScroll = _scrollController.position.maxScrollExtent;
      final double scrolled = _scrollController.position.pixels;

      if (scrolled >= (maxScroll - _loadingItemHeight)) {
        _loadNextPage();
      }
    }
  }

  /// If is last item attempt to load next page
  _loadNextPage() {
    if (_isLastPage) {
      return;
    }

    if (_itemsBeforeNextPage == _items.length) {
      return;
    }
    _itemsBeforeNextPage = _items.length;

    if (dataSource?.hasNextPageOfRequest<R>() == true) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        dataSource?.requestNextPageOfRequest<R>();
      });
    } else {
      _isLastPage = true;

      setStateNotDisposed(() {});
    }
  }

  /// Get previous item if able
  I? previousItem(int position) {
    if (position > 0) {
      return _items[position - 1];
    }

    return null;
  }
}
