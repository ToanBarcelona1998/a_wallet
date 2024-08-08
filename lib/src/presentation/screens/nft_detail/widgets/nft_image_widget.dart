import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';

class NFTDetailImageWidget extends StatelessWidget {
  final String url;
  final AppTheme appTheme;

  const NFTDetailImageWidget({
    super.key,
    required this.url,
    required this.appTheme,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        BorderRadiusSize.borderRadius04,
      ),
      child: NetworkImageWidget(
        url: url,
        width: double.maxFinite,
        height: double.maxFinite,
        appTheme: appTheme,
      ),
    );
  }
}
