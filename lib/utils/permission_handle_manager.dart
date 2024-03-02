import 'package:permission_handler/permission_handler.dart';

class PermissionHandleManager {
  Future<bool?> checkPermissionStorage() async {
    var status = await Permission.storage.status;
    if (status.isPermanentlyDenied) {
      return null;
    }
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  requestPermissionApp() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
    ].request();
  }

  Future<bool?> checkPermissionPhotos() async {
    var status = await Permission.photos.status;
    if (status.isPermanentlyDenied) {
      return null;
    }
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> checkPermissionCamera() async {
    var status = await Permission.camera.status;
    if (status.isPermanentlyDenied) {
      return null;
    }
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkPermissionMicro() async {
    var status = await Permission.microphone.status;
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> openStoragePermission() async {
    await Permission.storage.request();
  }

  Future<void> openLocationPermission() async {
    await Permission.location.request();
  }

  Future<void> openPhotosPermission() async {
    await Permission.photos.request();
  }

  Future<void> openCameraPermission() async {
    await Permission.camera.request();
  }

  Future<void> openMicroPermission() async {
    await Permission.microphone.request();
  }

  Future<bool> requestWifiInfoPermisson() async {
    // ignore: avoid_print
    print('Checking Android permissions');
    PermissionStatus status = await Permission.location.status;
    // Blocked?
    if (status.isDenied || status.isRestricted) {
      // Ask the user to unblock
      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        // ignore: avoid_print
        print('Location permission granted');
        return true;
      } else {
        // ignore: avoid_print
        print('Location permission not granted');
        return false;
      }
    } else {
      // ignore: avoid_print
      print('Permission already granted (previous execution?)');
      return true;
    }
  }
}
