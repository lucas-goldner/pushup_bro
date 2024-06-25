import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> setupLocalNotifications() async {
  const iosSetting = DarwinInitializationSettings();
  const initSettings = InitializationSettings(iOS: iosSetting);
  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

void showLocalNotification({required String title, required String body}) {
  const iosNotificatonDetail = DarwinNotificationDetails();
  const notificationDetails = NotificationDetails(
    iOS: iosNotificatonDetail,
  );
  flutterLocalNotificationsPlugin.show(0, title, body, notificationDetails);
}
