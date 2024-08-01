import 'package:domain/domain.dart';

extension AddBrowserParameterMapper on AddBrowserParameter {
  AddBrowserParameterDto get mapRequest => AddBrowserParameterDto(
        logo: logo,
        siteName: siteName,
        screenShotUri: screenShotUri,
        url: url,
      );
}

final class AddBrowserParameterDto {
  final String logo;
  final String siteName;
  final String screenShotUri;
  final String url;

  const AddBrowserParameterDto({
    required this.logo,
    required this.siteName,
    required this.screenShotUri,
    required this.url,
  });
}
