
 

import 'package:notitication_fikra_gym_out_side_project/notification_model.dart';

class RemoteNotificationModel extends NotificationModel {
  RemoteNotificationModel({
    required super.id,
    required super.sendType,
    required super.title,
    required super.text,
    required super.url,
    required super.imageFullLink,
    required super.activeFromDate,
    required super.activeToDate,
    required super.active,
    required super.warehousesIds,
    required super.repeated,
    required super.imageBase64,
  });

  factory RemoteNotificationModel.fromJson(Map<String, dynamic> json) {
    return RemoteNotificationModel(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        url: json['url'],
        active: json['active'],
        activeFromDate: json['active_from_date'],
        activeToDate: json['active_to_date'],
        warehousesIds: json['warehouses_ids'].cast<String>(),
        sendType: json['send_type'],
        repeated: json['repeated'],
        imageFullLink: json['image_full_link'],
        imageBase64: json['image_base64']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['text'] = text;
    data['url'] = url;
    data['active'] = active;
    data['active_from_date'] = activeFromDate;
    data['active_to_date'] = activeToDate;
    data['warehouses_ids'] = warehousesIds;
    data['send_type'] = sendType;
    data['repeated'] = repeated;
    data['image_full_link'] = imageFullLink;

    return data;
  }
}
