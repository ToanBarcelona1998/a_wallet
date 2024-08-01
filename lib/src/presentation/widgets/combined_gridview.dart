import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';

class CombinedGridView<T> extends StatefulWidget {
  static const double _defaultEndReachedThreshold = 200;

  final List<T> data;
  final Widget Function(T, int) builder;
  final void Function() onRefresh;
  final void Function() onLoadMore;
  final double loadMoreThreshHold;
  final bool canLoadMore;
  final Widget Function()? buildEmpty;
  final int childCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final ScrollPhysics ?physics;

  const CombinedGridView({
    super.key,
    required this.childCount,
    required this.onRefresh,
    required this.onLoadMore,
    required this.data,
    required this.builder,
    required this.canLoadMore,
    required this.childAspectRatio,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    this.loadMoreThreshHold = _defaultEndReachedThreshold,
    this.buildEmpty,
    this.physics,
  });

  @override
  State<CombinedGridView<T>> createState() => _CombinedGridViewState<T>();
}

class _CombinedGridViewState<T> extends State<CombinedGridView<T>> {
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
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.childCount,
              childAspectRatio: widget.childAspectRatio,
              crossAxisSpacing: widget.crossAxisSpacing,
              mainAxisSpacing: widget.mainAxisSpacing,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return widget.builder(
                  widget.data[index],
                  index,
                );
              },
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
                  padding: EdgeInsets.only(
                    bottom: Spacing.spacing05,
                  ),
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
