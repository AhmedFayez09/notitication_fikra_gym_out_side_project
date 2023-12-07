import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notitication_fikra_gym_out_side_project/constant.dart';
import 'package:notitication_fikra_gym_out_side_project/location_model/location_model.dart';
import 'package:notitication_fikra_gym_out_side_project/location_model/remote_location_model.dart';
import 'package:notitication_fikra_gym_out_side_project/noti_remote_model.dart';
import 'package:notitication_fikra_gym_out_side_project/notification_model.dart';


part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());
  static NotificationCubit get(context) => BlocProvider.of(context);

  Box<NotificationModel> notificationBox =
      Hive.box<NotificationModel>(kNotificationBox);
      
// 1- get List From  remote, r = list & l = []
  List<RemoteNotificationModel>? warehouseAds;
  void getRemoteListFun() async {
    emit(GetNotificationLoading());
    try {
      final response = await Dio().get(
          "https://app01.cloud-systems.org/demo-app-gym/api/v3/app/warehouse_ads",
          options: Options(headers: {"X-Api-Key": "Fekra0980952859IT"}));
      if (response.data["data"]["warehouse_ads"] != null) {
        warehouseAds = <RemoteNotificationModel>[];
        response.data["data"]["warehouse_ads"].forEach((v) {
          warehouseAds!.add(RemoteNotificationModel.fromJson(v));
        });
      }
      emit(GetNotificationSuccess());
    } catch (e) {
      print(e);
      emit(GetNotificationFailure(msg: e.toString()));
    }
  }

// 2- get List From local ,  r = list & l = []
  List<NotificationModel>? localListData;
  void getLocalListFun() {
    emit(GetLocalNotification());
    localListData = notificationBox.values.toList();
    print(localListData?.length);
  }

// 3- store remote list in local list
  void storeNotifications(RemoteNotificationModel ads) async {
    emit(StoreNotificationLoading());
    try {
      NotificationModel model = NotificationModel(
          id: ads.id,
          sendType: ads.sendType,
          title: ads.title,
          text: ads.text,
          url: ads.url,
          imageFullLink: ads.imageFullLink,
          activeFromDate: ads.activeFromDate,
          activeToDate: ads.activeToDate,
          active: ads.active,
          warehousesIds: ads.warehousesIds,
          repeated: ads.repeated,
          imageBase64: ads.imageBase64);
      await notificationBox.add(model);
      emit(StoreNotificationSuccess());
    } catch (err) {
      emit(StoreNotificationFailure());
    }
  }

// 4- check and store
  void checkToStore() {
    updateNotificationFun();
    getLocalListFun();
    if (warehouseAds != null) {
      if (warehouseAds?.isEmpty ?? false) {
        print("Delete");
        deleteAllCache();
      }
      warehouseAds?.forEach((remoteItem) {
        if (localListData!
            .where((localElement) => localElement.id == remoteItem.id)
            .isEmpty) {
          print("this mean that notification is not in local list");
          if (checkTimeInZoon(
              startTime: remoteItem.activeFromDate ?? '',
              endTime: remoteItem.activeToDate ?? '')) {
            if (remoteItem.active != '0') {
              storeNotifications(remoteItem);
            }
          }
        } else {
          print("this mean this notification is here in cache");
          localListData?.forEach((localElement) {
            DateTime endTime = DateTime.parse(localElement.activeToDate ?? '');
            if (DateTime.now().isAfter(endTime) || localElement.active == "0") {
              deleteNotification(localElement);
            } else {}
          });
        }
      });
    }
  }

  void updateNotificationFun() {
    if (warehouseAds != null) {
      localListData?.forEach((localItem) {
        if (warehouseAds?.map((e) => e.id).toList().contains(localItem.id) ==
            true) {
          updateLocalNotificationFelids(
            localNotification: localItem,
            newNotification: warehouseAds!
                .firstWhere((element) => element.id == localItem.id),
          );
        } else {
          deleteNotification(localItem);
        }
      });
    }
  }

  void deleteNotification(NotificationModel notification) {
    emit(DeleteNotificationLoading());
    notification.delete().then((value) {
      emit(DeleteNotificationSuccess());
    }).catchError((e) {
      print("in Delete Notifications the error is $e");
      emit(DeleteNotificationError());
    });
  }

  void deleteAllCache() {
    notificationBox.clear();
    emit(DeleteAllCacheState());
  }

  void updateDirectNotification(NotificationModel notification) {
    notification.isDeleted = "1";
    emit(UpdateDirectNotificationSuccess());
  }

  void updateLocalNotificationFelids({
    required NotificationModel localNotification,
    required NotificationModel newNotification,
  }) {
    emit(UpdateNotificationLoading());
    try {
      if (localNotification.active != newNotification.active) {
        localNotification.active = newNotification.active;
      }
      if (localNotification.repeated != newNotification.repeated) {
        localNotification.repeated = newNotification.repeated;
      }
      if (localNotification.imageFullLink != newNotification.imageFullLink) {
        localNotification.imageFullLink = newNotification.imageFullLink;
      }
      if (localNotification.sendType != newNotification.sendType) {
        localNotification.sendType = newNotification.sendType;
      }
      if (localNotification.warehousesIds != newNotification.warehousesIds) {
        localNotification.warehousesIds = newNotification.warehousesIds;
      }
      if (localNotification.title != newNotification.title) {
        localNotification.title = newNotification.title;
      }
      if (localNotification.text != newNotification.text) {
        localNotification.text = newNotification.text;
      }
      if (localNotification.activeFromDate != newNotification.activeFromDate) {
        localNotification.activeFromDate = newNotification.activeFromDate;
      }
      if (localNotification.activeToDate != newNotification.activeToDate) {
        localNotification.activeToDate = newNotification.activeToDate;
      }
      if (localNotification.url != newNotification.url) {
        localNotification.url = newNotification.url;
      }
      emit(UpdateNotificationSuccess());
    } catch (err) {
      emit(UpdateNotificationError());
    }
  }

  bool checkTimeInZoon({required String startTime, required String endTime}) {
    DateTime now = DateTime.now();
    DateTime startDateTime = DateTime.parse(startTime);
    DateTime endDateTime = DateTime.parse(endTime);
    return now.isAfter(startDateTime) && now.isBefore(endDateTime);
  }

// *****************************************************************************************

// to get remote list
  List<RemoteLocationModel>? remoteLocationList;
  void getRemoteLocation() async {
    emit(GetLocationLoading());
    try {
      final response = await Dio().get(
          "https://app01.cloud-systems.org/demo-app-gym/api/v3/app/warehouses",
          options: Options(headers: {"X-Api-Key": "Fekra0980952859IT"}));
      if (response.data["data"]["warehouses"] != null) {
        remoteLocationList = <RemoteLocationModel>[];
        response.data["data"]["warehouses"].forEach((v) {
          remoteLocationList?.add(RemoteLocationModel.fromJson(v));
        });
      }
      emit(GetLocationSuccess());
    } catch (err) {
      emit(GetLocationError());
    }
  }

  List<LocationModel>? localLocationList;
  Box<LocationModel> locationBox = Hive.box<LocationModel>(kLocationBox);
  void getLocalLocation() {
    localLocationList = locationBox.values.toList();
    emit(GetLocalLocationSuccess());
  }

  void storeLocation(RemoteLocationModel remoteLocation) async {
    emit(StoreLocalLocationLoading());
    try {
      LocationModel locationModel = LocationModel(
        id: remoteLocation.id,
        name: remoteLocation.name,
        lat: remoteLocation.lat,
        lng: remoteLocation.lng,
      );
      await locationBox.add(locationModel);

      emit(StoreLocalLocationSuccess());
    } catch (e) {
      emit(StoreLocalLocationError());
    }
  }
}
