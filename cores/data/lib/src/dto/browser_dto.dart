import 'package:domain/domain.dart';

extension BrowserDtoMapper on BrowserDto {
  Browser get toEntity => Browser(
        id: id,
        logo: logo,
        siteTitle: siteTitle,
        url: url,
        isActive: isActive,
        screenShotUri: screenShotUri,
      );
}

class BrowserDto {
  final int id;
  final String siteTitle;
  final String screenShotUri;
  final String logo;
  final String url;
  final bool isActive;

  const BrowserDto({
    required this.id,
    required this.logo,
    required this.siteTitle,
    required this.screenShotUri,
    required this.url,
    required this.isActive,
  });
}
