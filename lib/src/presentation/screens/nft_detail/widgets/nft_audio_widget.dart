import 'dart:async';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import 'nft_image_widget.dart';

class NFTDetailAudioWidget extends StatefulWidget {
  final String source;
  final String thumbnailUrl;
  final AppTheme appTheme;

  const NFTDetailAudioWidget({
    required this.source,
    required this.thumbnailUrl,
    required this.appTheme,
    super.key,
  });

  @override
  NFTDetailAudioWidgetState createState() => NFTDetailAudioWidgetState();
}

class NFTDetailAudioWidgetState extends State<NFTDetailAudioWidget>
    with WidgetsBindingObserver {
  late AudioPlayer player;
  late String source;
  late String thumbnailUrl;
  bool _showControl = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    init();

    player = AudioPlayer()
      ..setSource(UrlSource(source))
      ..onPlayerStateChanged.listen(_listenPlayer);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        if (player.state == PlayerState.playing) {
          player.pause();
        }
        break;
      case AppLifecycleState.resumed:
        if (player.state != PlayerState.playing) {
          player.play(UrlSource(source));
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  void _listenPlayer(PlayerState event) async {
    switch (event) {
      case PlayerState.paused:
        break;
      case PlayerState.playing:
        break;
      case PlayerState.stopped:
      case PlayerState.disposed:
        break;
      case PlayerState.completed:
        setState(() {
          _showControl = true;
        });
    }
  }

  Future<void> startPlayer() async {
    await player.seek(
      const Duration(seconds: 0),
    );

    await player.play(UrlSource(source));
    setState(() {
      _showControl = false;
    });
  }

  void init() {
    source = widget.source;
    thumbnailUrl = widget.thumbnailUrl;
  }

  @override
  void didUpdateWidget(covariant NFTDetailAudioWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    init();
  }

  @override
  void dispose() {
    Future.microtask(
      () async => await player.dispose(),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.32,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: _buildThumbnail(),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Visibility(
      visible: _showControl,
      child: NFTDetailImageWidget(
        url: thumbnailUrl,
        appTheme: widget.appTheme,
      ),
    );
  }
}
