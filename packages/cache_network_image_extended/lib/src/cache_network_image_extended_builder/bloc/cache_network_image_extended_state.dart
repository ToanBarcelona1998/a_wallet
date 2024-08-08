part of 'cache_network_image_extended_bloc.dart';

enum CacheNetworkImageExtendedStatus{
  loading,
  loaded,
  error,
}

class CacheImageState {
  final CacheNetworkImageExtendedStatus status;
  final Uint8List? image;
  final StackTrace? stackTrace;

  const CacheImageState({
    this.status = CacheNetworkImageExtendedStatus.loading,
    this.image,
    this.stackTrace,
  });
}
