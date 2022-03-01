import 'package:hive/hive.dart';
part 'route_model.g.dart';

@HiveType(typeId: 6)
class RouteModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<dynamic> coordinates;

  RouteModel({
    this.id,
    this.name,
    this.coordinates,
  });

  RouteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['coordinates'] != null) {
      coordinates = [];
      json['coordinates'].forEach((v) {
        coordinates.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
