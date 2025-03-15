import 'package:flutter/foundation.dart';

class DeelNotificationNotifier extends ChangeNotifier {
  int _notificationCount = 0;

  int get notificationCount => _notificationCount;

  void incrementNotifications() {
    _notificationCount++;
    notifyListeners(); // Notifica os widgets ouvintes sobre a mudança no estado
  }

  void resetNotifications() {
    _notificationCount = 0;
    notifyListeners();
  }
}
