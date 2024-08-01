import 'package:cache_network_image_extended/src/core/types.dart';
import 'package:flutter/material.dart';
import 'bloc/cache_network_image_extended_bloc.dart';

class CacheNetworkImageExtend extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double targetWidth;
  final double? height;
  final double targetHeight;
  final LoadingBuilder loadingBuilder;
  final ErrorBuilder errorBuilder;

  const CacheNetworkImageExtend({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    required this.targetWidth,
    this.height,
    required this.targetHeight,
    required this.loadingBuilder,
    required this.errorBuilder,
    Key? key,
  }) : super(key: key);

  @override
  State<CacheNetworkImageExtend> createState() =>
      _CacheNetworkImageExtendState();
}

class _CacheNetworkImageExtendState extends State<CacheNetworkImageExtend> {
  late CacheNetworkImageExtendedBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CacheNetworkImageExtendedBloc(
      url: widget.imageUrl,
      height: widget.targetHeight,
      width: widget.targetWidth,
    )..getImage();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(CacheNetworkImageExtend oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _bloc = (CacheNetworkImageExtendedBloc(
        url: widget.imageUrl,
        height: widget.targetHeight,
        width: widget.targetWidth,
      ));

      _bloc.getImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CacheImageState>(
      builder: (_, snapShot) {
        if (snapShot.hasData) {
          CacheImageState state = snapShot.data!;

          switch (state.status) {
            case CacheNetworkImageExtendedStatus.loading:
              return widget.loadingBuilder.call(
                context,
                _bloc.url,
                true,
              );
            case CacheNetworkImageExtendedStatus.error:
              return widget.errorBuilder.call(
                context,
                _bloc.url,
                state.stackTrace,
              );
            case CacheNetworkImageExtendedStatus.loaded:
              return Image.memory(
                state.image!,
                width: widget.width,
                height: widget.height,
                fit: widget.fit,
              );
          }
        }
        return const SizedBox();
      },
      stream: _bloc.streamCache,
    );
  }
}
