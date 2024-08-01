class GoogleAccount {
  final String email;
  final String? name;
  final String? profileImage;
  final String? idToken;
  final String? oAuthIdToken;
  final String? oAuthAccessToken;

  const GoogleAccount({
    this.idToken,
    required this.email,
    this.profileImage,
    this.oAuthIdToken,
    this.oAuthAccessToken,
    this.name,
  });
}
