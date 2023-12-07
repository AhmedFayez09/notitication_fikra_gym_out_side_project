import 'package:hive_flutter/hive_flutter.dart';
part 'location_model.g.dart';

@HiveType(typeId: 2)
class LocationModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String lat;
  @HiveField(3)
  final String lng;

  LocationModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });
}
