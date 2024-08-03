import 'package:permission_handler/permission_handler.dart';

Future<bool> notificationsIsEnabled() async {
  var status = await Permission.notification.status;
  return status.isGranted;
}
