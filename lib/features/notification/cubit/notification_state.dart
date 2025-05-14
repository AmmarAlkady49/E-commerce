part of 'notification_cubit.dart';

class NotificationState {}

final class NotificationInitial extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final List<NotificationMessageModel> notificationList;
  NotificationLoaded(this.notificationList);
}
