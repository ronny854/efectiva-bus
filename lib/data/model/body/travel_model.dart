
class TravelModel {
  String partnerId;
  String busId;
  String matricula;
  String operatorId;
  String operatorName;

  String routeId;
  String routeName;

  String driverId;
  String driverName;
  String driverImage;

  TravelModel(
      {this.busId,
      this.operatorId,
      this.routeId,
      this.driverId,
      this.partnerId,
      this.routeName,
      this.matricula,
      this.operatorName,
      this.driverName,
      this.driverImage});

  TravelModel.fromJson(Map<String, dynamic> json) {
    busId = json['busId'];
    operatorId = json['operatorId'];
    routeId = json['routeId'];
    driverId = json['driverId'];
    partnerId = json['partnerId'];
    routeName = json['routeName'];
    matricula = json['matricula'];
    operatorName = json['operatorName'];
    driverName = json['driverName'];
    driverImage = json['driverImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['busId'] = this.busId;
    data['operatorId'] = this.operatorId;
    data['routeId'] = this.routeId;
    data['driverId'] = this.driverId;
    data['partnerId'] = this.partnerId;
    data['routeName'] = this.routeName;
    data['matricula'] = this.matricula;
    data['operatorName'] = this.operatorName;
    data['driverName'] = this.driverName;
    data['driverImage'] = this.driverImage;
    return data;
  }
}
