import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:cache_network_image_extended/cache_network_image_extended.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StatelessWidget {
  final String url;
  final AppTheme appTheme;
  final double? cacheTarget;
  final double? width;
  final double? height;

  const NetworkImageWidget({
    required this.url,
    required this.appTheme,
    this.cacheTarget,
    this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CacheNetworkImageExtend(
      imageUrl: url,
      targetWidth: cacheTarget ?? context.cacheImageTarget,
      targetHeight: cacheTarget ?? context.cacheImageTarget,
      width: width,
      height: height,
      loadingBuilder: (context, url, onProcess) {
        return Shimmer.fromColors(
          baseColor: appTheme.utilityCyan100,
          highlightColor: appTheme.utilityPink100,
          child: SizedBox(
            width: width,
            height: height,
          ),
        );
      },
      errorBuilder: (context, url, error) {
        return SvgPicture.asset(
          AssetLogoPath.logo,
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      },
      fit: BoxFit.cover,
    );
  }
}
