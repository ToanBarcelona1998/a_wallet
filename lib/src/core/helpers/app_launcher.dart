import 'package:url_launcher/url_launcher.dart' as launcher;

sealed class AppLauncher {
  static Future<void> launch(String url) async {
    await launcher.launchUrl(
      Uri.parse(
        url,
      ),
      mode: launcher.LaunchMode.externalApplication,
    );
  }
}
