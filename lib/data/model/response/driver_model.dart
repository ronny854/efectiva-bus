class DriverModel {
  String names;
  String photoUrl;
  String driverId;

  DriverModel({
    this.names="",
    this.photoUrl,
    this.driverId,
  });

  DriverModel.fromJson(Map<String, dynamic> json) {
    names = json['names'];
    photoUrl = json['photoUrl'];
    driverId = json['driverId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['names'] = this.names;
    data['photoUrl'] = this.photoUrl;
    data['driverId'] = this.driverId;
    return data;
  }
}
