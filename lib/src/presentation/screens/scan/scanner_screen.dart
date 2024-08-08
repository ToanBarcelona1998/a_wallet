import 'package:a_wallet/src/application/global/app_theme/app_theme.dart';
import 'package:a_wallet/src/application/global/app_theme/app_theme_builder.dart';
import 'package:a_wallet/src/application/global/localization/app_localization_provider.dart';
import 'package:a_wallet/src/core/constants/asset_path.dart';
import 'package:a_wallet/src/core/constants/language_key.dart';
import 'package:a_wallet/src/core/constants/size_constant.dart';
import 'package:a_wallet/src/core/constants/typography.dart';
import 'package:a_wallet/src/core/helpers/image_picker_helper.dart';
import 'package:a_wallet/src/core/helpers/scan_validator.dart';
import 'package:a_wallet/src/core/helpers/system_permission_helper.dart';
import 'package:a_wallet/src/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'widgets/scanner_app_bar_widget.dart';
import 'widgets/scanner_overlay.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller =
      MobileScannerController(autoStart: true, formats: [
    BarcodeFormat.all,
  ]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (appTheme) {
        return AppLocalizationProvider(builder: (localization) {
          return Scaffold(
            body: Stack(
              children: [
                MobileScanner(
                  onDetect: (barcodes) => _onBarcodeCapture(
                    barcodes,
                    appTheme,
                  ),
                  controller: _controller,
                  errorBuilder: (_, exception, child) {
                    return const SizedBox.shrink();
                  },
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: ScannerOverLayShape(
                      borderColor: appTheme.borderPrimary,
                      overlayColor: appTheme.alphaBlack70.withOpacity(
                        0.7,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: ScannerAppBarWidget(
                    appTheme: appTheme,
                    localization: localization,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      _showRequestCameraPermission(
                        appTheme,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.spacing04,
                        vertical: Spacing.spacing03,
                      ),
                      margin: const EdgeInsets.only(
                        bottom: BoxSize.boxSize11,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: appTheme.borderPrimary,
                        ),
                        borderRadius: BorderRadius.circular(
                          BorderRadiusSize.borderRadius06,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AssetIconPath.icScannerPhoto,
                          ),
                          const SizedBox(
                            width: BoxSize.boxSize03,
                          ),
                          Text(
                            localization.translate(
                              LanguageKey.scanScreenUploadPhoto,
                            ),
                            style: AppTypoGraPhy.textXsMedium.copyWith(
                              color: appTheme.textWhite,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  void _openScan() async {
    final String? path = await ImagePickerHelper.pickSingleImage();

    if (path == null) return;

    await _controller.analyzeImage(path);
  }

  void _showRequestCameraPermission(AppTheme appTheme) async {
    PermissionStatus status =
        await SystemPermissionHelper.getCurrentPhotoPermissionStatus();

    if (status.isGranted) {
      _openScan();
    } else {
      if (context.mounted) {
        SystemPermissionHelper.requestPhotoPermission(
          onSuccessFul: _openScan,
          reject: () {
            SystemPermissionHelper.goToSettings();
          },
        );
      }
    }
  }

  void _onBarcodeCapture(
    BarcodeCapture barcodeCapture,
    AppTheme appTheme,
  ) async {
    if (barcodeCapture.barcodes.isEmpty) return;

    await _controller.stop();

    final barcode = barcodeCapture.barcodes[0];

    final ScanResult scanResult =
        ScanValidator.validateResult(barcode.rawValue ?? '');

    if (scanResult.type == ScanResultType.other) {
      _showInValidQrCode(appTheme);
    } else {
      AppNavigator.pop(
        scanResult,
      );
    }
  }

  void _showInValidQrCode(
    AppTheme appTheme,
  ) {
    // show error
  }
}
