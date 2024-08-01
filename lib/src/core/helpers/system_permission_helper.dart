import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

sealed class SystemPermissionHelper {
  static Future<PermissionStatus> getCurrentCameraPermissionStatus() async {
    return await Permission.camera.status;
  }

  static Future<void> requestCameraPermission({
    required VoidCallback onSuccessFul,
    required VoidCallback reject,
  }) async {

    PermissionStatus status = await getCurrentCameraPermissionStatus();

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.camera.request();
    }else{
      onSuccessFul();

      return;
    }

    bool isSuccessFul = !status.isPermanentlyDenied && !status.isDenied;

    if (isSuccessFul) {
      onSuccessFul();
    } else {
      reject();
    }
  }

  static Future<PermissionStatus> getCurrentPhotoPermissionStatus() async {
    return await Permission.photos.status;
  }

  static Future<void> requestPhotoPermission({
    required VoidCallback onSuccessFul,
    required VoidCallback reject,
  }) async {

    PermissionStatus status = await getCurrentPhotoPermissionStatus();

    if (status.isDenied || status.isPermanentlyDenied) {
      status = await Permission.photos.request();
    }else{
      onSuccessFul();

      return;
    }

    bool isSuccessFul = !status.isPermanentlyDenied && !status.isDenied;

    if (isSuccessFul) {
      onSuccessFul();
    } else {
      reject();
    }
  }

  static Future<void> goToSettings() {
    return openAppSettings();
  }
}
