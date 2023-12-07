import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:math' as math;

import 'package:notitication_fikra_gym_out_side_project/notification_cubit.dart';
import 'package:notitication_fikra_gym_out_side_project/notification_item.dart';

 
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationCubit>(context).getRemoteListFun();
    BlocProvider.of<NotificationCubit>(context).updateNotificationFun();
    BlocProvider.of<NotificationCubit>(context).checkToStore();
    BlocProvider.of<NotificationCubit>(context).getLocalListFun();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationState>(
      listener: (context, state) {
        var cubit = NotificationCubit.get(context);
        if (state is GetNotificationSuccess) {
          cubit.updateNotificationFun();
          cubit.checkToStore();
          cubit.getLocalListFun();
        }
        if (state is DeleteNotificationSuccess ||
            state is DeleteAllCacheState) {
          cubit.getLocalListFun();
        }
      },
      builder: (context, state) {
        var cubit = NotificationCubit.get(context);
        var list = cubit.localListData
            ?.where((element) => element.isDeleted == "0")
            .toList();
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              cubit.getRemoteListFun();
              cubit.updateNotificationFun();
              cubit.getLocalListFun();
              cubit.checkToStore();
         
            },
            child: ListView(
              children: [
                const SizedBox(height: 200),
                list == null
                    ? const Center(child: CircularProgressIndicator())
                    : list.isEmpty
                        ? const Center(child: Text("List is Empty"))
                        : ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var item = list[index];
                              return NotificationItem(
                                onPressDelete: () {
                                  if (item.sendType == "1") {
                                    cubit.updateDirectNotification(item);
                                  } else {
                                    cubit.deleteNotification(item);
                                  }
                                },
                                notificationItem: item,
                              );
                            },
                          ),
              ],
            ),
          ),
          bottomNavigationBar: Row(
            children: [
              TextButton(
                onPressed: () {
                  print("${cubit.localListData}");
                  cubit.localListData?.forEach((element) {
                    print(element.title);
                  });
           
                },
                child: const Text("Show list in Cache"),
              ),
            ],
          ),
        );
      },
    );
  }
}
