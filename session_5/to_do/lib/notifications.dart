import 'package:awesome_notifications/awesome_notifications.dart';
import 'dart:async';

int num = 0;

int createUniqueId() {
  num += 1;
  return num;
}

Future<void> onedayNotifications(String title) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: 'Only 24 hours left!',
        body: 'Task: $title',
        notificationLayout: NotificationLayout.BigText),
  );
}

Future<void> onehourNotifications(String title) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: createUniqueId(),
        channelKey: 'basic_channel',
        title: 'Only 1 hour left!',
        body: 'Task: $title',
        notificationLayout: NotificationLayout.BigText),
  );
}
