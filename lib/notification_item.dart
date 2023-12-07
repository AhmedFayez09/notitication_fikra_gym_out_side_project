import 'dart:math';
import 'package:flutter/material.dart';
import 'package:notitication_fikra_gym_out_side_project/constant.dart';
import 'package:notitication_fikra_gym_out_side_project/notification_model.dart';
 
  
class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notificationItem,
    required this.onPressDelete,
  });
  final NotificationModel notificationItem;
  final VoidCallback onPressDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: getRandomColor(),
      height: 50,
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(notificationItem.imageFullLink ??
              "https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png"),
          Text(notificationItem.title ?? ''),
          const SizedBox(width: 10),
          Text("${notificationItem.sendType}"),
          IconButton(
            onPressed: onPressDelete,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  Color getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }
}
