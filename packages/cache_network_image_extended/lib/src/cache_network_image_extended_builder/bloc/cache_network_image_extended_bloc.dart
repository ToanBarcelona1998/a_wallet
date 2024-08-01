import 'dart:async';
import 'dart:typed_data' as type;
import 'dart:ui';
import 'package:cache_network_image_extended/src/core/cache_image_extended_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

part 'cache_network_image_extended_state.dart';

class CacheNetworkImageExtendedBloc {
  final String url;
  final double height;
  final double width;

  CacheNetworkImageExtendedBloc({
    required this.url,
    required this.height,
    required this.width,
  });

  final CacheNetworkImageExtendedManager cacheImageManager =
      const CacheNetworkImageExtendedManager();

  final StreamController<CacheImageState> _cacheController = StreamController();

  Stream<CacheImageState> get streamCache => _cacheController.stream;

  Sink<CacheImageState> get sinkCache => _cacheController.sink;

  CacheNetworkImageExtendedStatus status =
      CacheNetworkImageExtendedStatus.loading;

  StackTrace? stackTrace;

  type.Uint8List? image;

  @mustCallSuper
  void close() {
    if (_cacheController.hasListener) {
      _cacheController.close();
    }
  }

  Future<void> _cacheImage(String url) async {
    if (image == null) throw ('not complete cache image');
    await cacheImageManager.cacheImage(
      url,
      image!,
      'png',
    );
  }

  Future<void> getImage() async {
    try {
      String originalUrl = url;
      // FlutterCoreTNVLogger.logI("origin ur; = $url");
      double widthBuilder = width;
      double heightBuilder = height;

      ///
      status = CacheNetworkImageExtendedStatus.loading;
      stackTrace = null;

      sinkCache.add(
        CacheImageState(
          status: status,
          image: image,
          stackTrace: stackTrace,
        ),
      );

      ///
      ///download image from server or cache
      bool fromCache = true;

      String downLoadUrl = '$originalUrl?w=$widthBuilder&h=$heightBuilder';

      FileInfo? fileInfo = await cacheImageManager.getImage(originalUrl);

      if (fileInfo == null) {
        fromCache = false;
        fileInfo = await cacheImageManager.downLoadFile(downLoadUrl);
      } else {
      }

      if (fromCache) {
        image = await fileInfo.file.readAsBytes();

        status = CacheNetworkImageExtendedStatus.loaded;
        return;
      }

      final bytes = await fileInfo.file.readAsBytes();
      final codec = await instantiateImageCodec(
        bytes,
        targetWidth: widthBuilder.toInt(),
        targetHeight: heightBuilder.toInt(),
      );
      final frame = await codec.getNextFrame();
      final data = await frame.image.toByteData(format: ImageByteFormat.png);

      if (data == null) {
        status = CacheNetworkImageExtendedStatus.error;
        return;
      }
      image = data.buffer.asUint8List();
      if (!fromCache) {
        unawaited(
          _cacheImage(originalUrl),
        );
      }

      status = CacheNetworkImageExtendedStatus.loaded;

      ///
    } catch (e, s) {
      stackTrace = s;
      status = CacheNetworkImageExtendedStatus.error;
    } finally {
      sinkCache.add(CacheImageState(
        status: status,
        image: image,
        stackTrace: stackTrace,
      ));
    }
  }
}
