import 'package:domain/domain.dart';

extension GoogleAccountDtoMapper on GoogleAccountDto {
  GoogleAccount get toEntities => GoogleAccount(
        email: email,
        name: name,
        idToken: idToken,
        oAuthAccessToken: oAuthAccessToken,
        oAuthIdToken: oAuthIdToken,
        profileImage: profileImage,
      );
}

class GoogleAccountDto {
  final String email;
  final String? name;
  final String? profileImage;
  final String? idToken;
  final String? oAuthIdToken;
  final String? oAuthAccessToken;

  const GoogleAccountDto({
    this.idToken,
    required this.email,
    this.profileImage,
    this.oAuthIdToken,
    this.oAuthAccessToken,
    this.name,
  });
}
