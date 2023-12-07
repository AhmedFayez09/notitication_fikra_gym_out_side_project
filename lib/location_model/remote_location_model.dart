 
 
import 'package:notitication_fikra_gym_out_side_project/location_model/location_model.dart';

class RemoteLocationModel extends LocationModel {
  RemoteLocationModel({
    required super.id,
    required super.name,
    required super.lat,
    required super.lng,
  });
  factory RemoteLocationModel.fromJson(Map<String, dynamic> json) {
    return RemoteLocationModel(
      id: json['id'],
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
