import 'dart:math';
import 'dart:developer' as developer;
import 'package:e_commerce_graduation/features/notification/models/notification_message_model.dart';
import 'package:e_commerce_graduation/features/notification/services/local_notification_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  final List<NotificationMessageModel> _notificationList =
      dummyRepeatedNotificationList
          .map(
              (item) => NotificationMessageModel(title: item[0], body: item[1]))
          .toList();

  Timer? _timer;

  // void showNow() {
  //   _showRandomNotification();
  // }


  void getDummyRepeatedNotificationList() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      _showRandomNotification();
    });
    emit(NotificationLoaded(_notificationList));
  }

  void _showRandomNotification() {
    final random = Random();
    final index = random.nextInt(_notificationList.length);
    final notification = _notificationList[index];

    developer.log(
        "Showing notification: ${notification.title} - ${notification.body}");
    LocalNotificationServices.showSingleNotification(
      notification.title,
      notification.body,
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
