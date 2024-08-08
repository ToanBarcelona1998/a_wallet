import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/enum.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/helpers/nft_helper.dart';
import 'package:a_wallet/src/core/utils/context_extension.dart';
import 'package:a_wallet/src/presentation/screens/nft_detail/widgets/nft_audio_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'nft_image_widget.dart';
import 'nft_video_widget.dart';

class NFTMediaBuilder extends StatelessWidget {
  final NFTOffChainMediaInfo mediaInfo;
  final AppTheme appTheme;

  const NFTMediaBuilder({
    required this.mediaInfo,
    required this.appTheme,
    super.key,
  });

  MediaType get mediaType => NFTHelper.getMediaType(
        mediaInfo,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: context.h * 2 / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          BorderRadiusSize.borderRadius04,
        ),
      ),
      child: _buildLayout(),
    );
  }

  Widget _buildLayout() {
    switch (mediaType) {
      case MediaType.image:
        return NFTDetailImageWidget(
          url: mediaInfo.image.url ?? '',
          appTheme: appTheme,
        );
      case MediaType.video:
        return NFTDetailVideoWidget(
          thumbUrl: mediaInfo.image.url ?? '',
          source: mediaInfo.animation?.url,
          appTheme: appTheme,
        );
      case MediaType.audio:
        return NFTDetailAudioWidget(
          source: mediaInfo.animation?.url ?? '',
          thumbnailUrl: mediaInfo.image.url ?? '',
          appTheme: appTheme,
        );
      default:
        return NFTDetailImageWidget(
          url: mediaInfo.image.url ?? '',
          appTheme: appTheme,
        );
    }
  }
}
