final class UpdateBrowserParameter {
  final int id;
  final String ?logo;
  final String ?siteName;
  final String ?screenShotUri;
  final String ?url;
  final bool ?isActive;

  const UpdateBrowserParameter({
    required this.id,
    this.logo,
    this.siteName,
    this.screenShotUri,
    this.url,
    this.isActive,
  });
}
