import 'package:domain/domain.dart';

extension UpdateBrowserParameterMapper on UpdateBrowserParameter {
  UpdateBrowserParameterDto get mapRequest => UpdateBrowserParameterDto(
        id: id,
        logo: logo,
        isActive: isActive,
        screenShotUri: screenShotUri,
        siteName: siteName,
        url: url,
      );
}

final class UpdateBrowserParameterDto {
  final int id;
  final String? logo;
  final String? siteName;
  final String? screenShotUri;
  final String? url;
  final bool? isActive;

  const UpdateBrowserParameterDto({
    required this.id,
    this.logo,
    this.siteName,
    this.screenShotUri,
    this.url,
    this.isActive,
  });
}
