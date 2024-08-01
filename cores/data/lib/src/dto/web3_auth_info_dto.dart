import 'package:domain/domain.dart';

extension Web3AuthInfoDtoMapper on Web3AuthInfoDto {
  Web3AuthInfo get toEntities => Web3AuthInfo(
        email: email,
        name: name,
        idToken: idToken,
        oAuthAccessToken: oAuthAccessToken,
        oAuthIdToken: oAuthIdToken,
        profileImage: profileImage,
      );
}

final class Web3AuthInfoDto {
  final String email;
  final String? name;
  final String? profileImage;
  final String? idToken;
  final String? oAuthIdToken;
  final String? oAuthAccessToken;

  const Web3AuthInfoDto({
    this.idToken,
    required this.email,
    this.profileImage,
    this.oAuthIdToken,
    this.oAuthAccessToken,
    this.name,
  });
}
