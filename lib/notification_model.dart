import 'package:hive/hive.dart';
part 'notification_model.g.dart';

@HiveType(typeId: 1)
class NotificationModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  String? sendType;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? text;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? imageFullLink;
  @HiveField(6)
  String? activeFromDate;
  @HiveField(7)
  String? activeToDate;
  @HiveField(8)
  String? active;
  @HiveField(9)
  List<String>? warehousesIds;
  @HiveField(10)
  String? repeated;
  @HiveField(11)
  String? isDeleted;
  @HiveField(12)
  String? imageBase64;
 

  NotificationModel({
    required this.id,
    required this.sendType,
    required this.title,
    required this.text,
    required this.url,
    required this.imageFullLink,
    required this.activeFromDate,
    required this.activeToDate,
    required this.active,
    required this.warehousesIds,
    required this.repeated,
    required this.imageBase64,
    this.isDeleted = '0',
  });
}
