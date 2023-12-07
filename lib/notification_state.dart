part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetNotificationLoading extends NotificationState {}

class GetNotificationSuccess extends NotificationState {}

class GetNotificationFailure extends NotificationState {
  final String msg;
  GetNotificationFailure({required this.msg});
}

class StoreNotificationLoading extends NotificationState {}

class StoreNotificationSuccess extends NotificationState {}

class StoreNotificationFailure extends NotificationState {}

class GetLocalNotification extends NotificationState {}

class DeleteNotificationLoading extends NotificationState {}

class DeleteNotificationSuccess extends NotificationState {}

class DeleteNotificationError extends NotificationState {}

class UpdateNotificationError extends NotificationState {}

class UpdateNotificationSuccess extends NotificationState {}

class UpdateNotificationLoading extends NotificationState {}
class UpdateDirectNotificationSuccess extends NotificationState {}
class DeleteAllCacheState extends NotificationState {}
//***************************** *
class GetLocationSuccess extends NotificationState {}
class GetLocationLoading extends NotificationState {}
class GetLocationError extends NotificationState {}
class GetLocalLocationSuccess extends NotificationState {}
class StoreLocalLocationSuccess extends NotificationState {}
class StoreLocalLocationLoading extends NotificationState {}
class StoreLocalLocationError extends NotificationState {}

