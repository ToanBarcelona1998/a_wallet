import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/utils/dart_core_extension.dart';
import 'package:flutter/material.dart';
import 'nft_image_widget.dart';
import 'package:video_player/video_player.dart';

class NFTDetailVideoWidget extends StatefulWidget {
  final String thumbUrl;
  final String? source;
  final AppTheme appTheme;

  const NFTDetailVideoWidget({
    super.key,
    this.source,
    required this.thumbUrl,
    required this.appTheme,
  });

  @override
  State<NFTDetailVideoWidget> createState() => NFTDetailVideoWidgetState();
}

class NFTDetailVideoWidgetState extends State<NFTDetailVideoWidget> {
  VideoPlayerController? _controller;
  bool _showControl = true;

  void _init() {
    if (widget.source.isNotNullOrEmpty) {
      final Uri? url = Uri.tryParse(widget.source!);
      if (url != null) {
        _controller = VideoPlayerController.networkUrl(
          url,
        )
          ..initialize().then((_) {
            setState(() {});
            _onPlayPress();
          })
          ..addListener(_onVideoStateChanged);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(covariant NFTDetailVideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(widget.source != oldWidget.source){
      _init();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_onVideoStateChanged);
    _controller?.dispose();
    super.dispose();
  }

  void _onVideoStateChanged() {
    if (!_controller!.value.isPlaying && !_showControl) {
      setState(() => _showControl = true);
    }
  }

  void _onPlayPress() async {
    await _controller?.setPlaybackSpeed(1);
    await _controller?.play();
    setState(
      () => _showControl = false,
    );
  }

  Widget _buildVideo() {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const SizedBox.shrink();
    }

    return VideoPlayer(_controller!);
  }

  Widget _buildThumbnail() {
    return Visibility(
      visible: _showControl,
      child: NFTDetailImageWidget(
        url: widget.thumbUrl,
        appTheme: widget.appTheme,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildVideo(),
        _buildThumbnail(),
      ],
    );
  }
}
