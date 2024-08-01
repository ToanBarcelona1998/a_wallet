import 'package:data/data.dart';
import 'package:isar/isar.dart';

part 'browser_db.g.dart';

extension AddBrowserRequestDtoMapper on AddBrowserParameterDto {
  BrowserDb get toDb => BrowserDb(
        url: url,
        logo: logo,
        title: siteName,
        screenShotUri: screenShotUri,
        isActive: true,
      );
}

extension BrowserDbExtension on BrowserDb {
  BrowserDb copyWith({
    Id? id,
    String? url,
    String? logo,
    String? title,
    String? screenShotUri,
    bool? isActive,
  }) {
    return BrowserDb(
      id: id ?? this.id,
      url: url ?? this.url,
      logo: logo ?? this.logo,
      title: title ?? this.title,
      screenShotUri: screenShotUri ?? this.screenShotUri,
      isActive: isActive ?? this.isActive,
    );
  }

  BrowserDto get toDto => BrowserDto(
        id: id,
        logo: logo,
        siteTitle: title,
        screenShotUri: screenShotUri,
        url: url,
        isActive: isActive,
      );
}

@Collection(
  inheritance: false,
)
final class BrowserDb {
  final Id id;
  final String url;
  final String logo;
  final String title;
  final String screenShotUri;
  final bool isActive;

  BrowserDb({
    required this.url,
    required this.logo,
    required this.title,
    required this.screenShotUri,
    this.id = Isar.autoIncrement,
    required this.isActive,
  });
}
