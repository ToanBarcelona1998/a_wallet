import 'package:share_plus/share_plus.dart';

sealed class ShareNetWork {
  static Future<bool> shareText(String address) async {
    final shareResult = await Share.share(address);

    return shareResult.status == ShareResultStatus.success;
  }

  static Future<bool> shareUri(String browserAddress) async {
    final shareResult = await Share.shareUri(
      Uri.parse(
        browserAddress,
      ),
    );

    return shareResult.status == ShareResultStatus.success;
  }
}
