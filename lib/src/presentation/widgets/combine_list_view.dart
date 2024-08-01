import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CombinedListView<T> extends StatefulWidget {
  static const double _defaultEndReachedThreshold = 200;

  final List<T> data;
  final Widget Function(T,int) builder;
  final void Function() onRefresh;
  final void Function() onLoadMore;
  final double loadMoreThreshHold;
  final bool canLoadMore;
  final Widget Function()? buildEmpty;
  final ScrollPhysics ?physics;

  const CombinedListView({
    super.key,
    required this.onRefresh,
    required this.onLoadMore,
    required this.data,
    required this.builder,
    required this.canLoadMore,
    this.loadMoreThreshHold = _defaultEndReachedThreshold,
    this.buildEmpty,
    this.physics,
  });

  @override
  State<CombinedListView<T>> createState() => _CombinedListViewState<T>();
}

class _CombinedListViewState<T> extends State<CombinedListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      _scrollController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final thresholdReached =
        _scrollController.position.extentAfter < widget.loadMoreThreshHold;

    if (thresholdReached && widget.canLoadMore) {
      widget.onLoadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty && widget.buildEmpty != null) {
      return widget.buildEmpty!();
    }

    return CustomScrollView(
      controller: _scrollController,
      physics: widget.physics ?? const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () async => widget.onRefresh(),
        ),
        SliverPadding(
          padding: EdgeInsets.zero,
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => widget.builder(widget.data[index],index),
              childCount: widget.data.length,
              addAutomaticKeepAlives: true,
              findChildIndexCallback: (key) {
                final ValueKey<T?> contactKey = key as ValueKey<T>;

                final data = contactKey.value;

                if (data != null && widget.data.contains(data) == true) {
                  final index = widget.data.indexOf(data);

                  if (index > 0) return index;

                  return null;
                }

                return null;
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: widget.canLoadMore
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
