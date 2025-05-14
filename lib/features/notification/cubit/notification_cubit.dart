import 'package:e_commerce_graduation/features/notification/models/notification_message_model.dart';
import 'package:e_commerce_graduation/features/notification/services/local_notification_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  final List<NotificationMessageModel> _notificationList =
      dummyRepeatedNotificationList
          .map(
              (item) => NotificationMessageModel(title: item[0], body: item[1]))
          .toList();

  int _currentIndex = 0;

  void getDummyRepeatedNotificationList() {
    _showCurrentNotification();
    emit(NotificationLoaded(_notificationList));
  }

  void _showCurrentNotification() {
    final currentNotification = _notificationList[_currentIndex];
    LocalNotificationServices.showRepeatedNotification(
      currentNotification.title,
      currentNotification.body,
    );

    _currentIndex = (_currentIndex + 1) % _notificationList.length;
  }

  void showNextNotificationInOrder() {
    _showCurrentNotification();
  }
}
