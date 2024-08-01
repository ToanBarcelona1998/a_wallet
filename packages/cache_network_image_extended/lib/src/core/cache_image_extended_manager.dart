import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheNetworkImageExtendedManager {
  const CacheNetworkImageExtendedManager();

  static final DefaultCacheManager _cacheManager = DefaultCacheManager();

  Future<void> cacheImage(String url, Uint8List image,
      [String extension = 'png']) async {
    await _cacheManager
        .putFile(url, image, fileExtension: extension, key: url);
  }

  FutureOr<FileInfo> downLoadFile(String url) async {
    return await _cacheManager.downloadFile(url);
  }

  FutureOr<FileInfo?> getImage(String url) async {
    return await _cacheManager.getFileFromCache(url);
  }

  void removeFile(String key) {
    _cacheManager.removeFile(key);
  }

  Future<void> emptyCache() async {
    return await _cacheManager.emptyCache();
  }
}
