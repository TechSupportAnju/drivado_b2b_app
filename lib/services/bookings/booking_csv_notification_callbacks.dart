import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';

/// Required by [FlutterLocalNotificationsPlugin] when the app is in the background.
@pragma('vm:entry-point')
void bookingCsvNotificationBackgroundTap(NotificationResponse notificationResponse) {
  final path = notificationResponse.payload;
  if (path != null && path.isNotEmpty) {
    OpenFilex.open(path);
  }
}
