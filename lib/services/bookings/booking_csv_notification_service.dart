import 'package:drivado_b2b_app/services/bookings/booking_csv_notification_callbacks.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_filex/open_filex.dart';

/// Local notification when a booking CSV is saved; tap opens the file.
class BookingCsvNotificationService {
  BookingCsvNotificationService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'booking_csv_exports';
  static const _channelName = 'Booking reports';
  static const _notificationId = 9142001;

  static bool _initialized = false;

  static void _onForegroundTap(NotificationResponse response) {
    final path = response.payload;
    if (path != null && path.isNotEmpty) {
      OpenFilex.open(path);
    }
  }

  /// Call once from [main] after [WidgetsFlutterBinding.ensureInitialized].
  static Future<void> init() async {
    if (kIsWeb || _initialized) return;

    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      _initialized = true;
      return;
    }

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwinInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: darwinInit,
    );

    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onForegroundTap,
      onDidReceiveBackgroundNotificationResponse:
          bookingCsvNotificationBackgroundTap,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            _channelId,
            _channelName,
            description: 'Booking CSV download complete',
            importance: Importance.high,
          ),
        );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    final launched = await _plugin.getNotificationAppLaunchDetails();
    if (launched?.didNotificationLaunchApp == true) {
      final path = launched!.notificationResponse?.payload;
      if (path != null && path.isNotEmpty) {
        OpenFilex.open(path);
      }
    }

    _initialized = true;
  }

  /// Shows a system notification; payload is the absolute file path for [OpenFilex].
  static Future<void> showCsvSaved({
    required String filePath,
    required String fileName,
  }) async {
    if (kIsWeb) return;
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }
    if (!_initialized) {
      await init();
    }

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'Booking CSV download complete',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'Booking report',
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        subtitle: fileName,
      ),
    );

    await _plugin.show(
      id: _notificationId,
      title: 'Booking report saved',
      body: 'Tap to open $fileName',
      notificationDetails: details,
      payload: filePath,
    );
  }
}
