import 'package:hive/hive.dart';

part 'partner_information_model.g.dart';

@HiveType(typeId: 0)
class PartnerInformationResponse extends HiveObject {
  @HiveField(0)
  Bus bus;
  @HiveField(1)
  List<Drivers> drivers;
  @HiveField(2)
  Device device;
  // @HiveField(3)
  // String partnerId;
  // @HiveField(4)
  // String partnerNames;
  // @HiveField(5)
  // String partnerPhotoUrl;
  PartnerInformationResponse({this.bus, this.drivers, this.device});

  PartnerInformationResponse.fromJson(Map<String, dynamic> json) {
    bus = json['bus'] != null ? new Bus.fromJson(json['bus']) : null;
    if (json['drivers'] != null) {
      drivers = [];
      json['drivers'].forEach((v) {
        drivers.add(new Drivers.fromJson(v));
      });
    }
    device =
        json['device'] != null ? new Device.fromJson(json['device']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bus != null) {
      data['bus'] = this.bus.toJson();
    }
    if (this.drivers != null) {
      data['drivers'] = this.drivers.map((v) => v.toJson()).toList();
    }
    if (this.device != null) {
      data['device'] = this.device.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 1)
class Bus extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String matricula;
  @HiveField(2)
  Operator operator;

  Bus({this.id, this.matricula, this.operator});

  Bus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matricula = json['matricula'];
    operator = json['operator'] != null
        ? new Operator.fromJson(json['operator'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['matricula'] = this.matricula;
    if (this.operator != null) {
      data['operator'] = this.operator.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 2)
class Operator extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String operatorType;
  @HiveField(3)
  String transportType;
  @HiveField(4)
  bool enableManualRate;
  @HiveField(5)
  int priceNormal;
  @HiveField(6)
  int priceSpecial;
  @HiveField(7)
  List<Rates> rates;

  Operator(
      {this.id,
      this.name,
      this.operatorType,
      this.transportType,
      this.enableManualRate,
      this.priceNormal,
      this.priceSpecial,
      this.rates});

  Operator.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    operatorType = json['operatorType'];
    transportType = json['transportType'];
    enableManualRate = json['enableManualRate'];
    priceNormal = json['priceNormal'];
    priceSpecial = json['priceSpecial'];
    if (json['rates'] != null) {
      rates = [];
      json['rates'].forEach((v) {
        rates.add(new Rates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['operatorType'] = this.operatorType;
    data['transportType'] = this.transportType;
    data['enableManualRate'] = this.enableManualRate;
    data['priceNormal'] = this.priceNormal;
    data['priceSpecial'] = this.priceSpecial;
    if (this.rates != null) {
      data['rates'] = this.rates.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

@HiveType(typeId: 3)
class Rates extends HiveObject {
  @HiveField(0)
  String description;
  @HiveField(1)
  int price;

  Rates({this.description, this.price});

  Rates.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['price'] = this.price;
    return data;
  }
}

@HiveType(typeId: 4)
class Drivers extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String names;
  @HiveField(2)
  String lastNames;
  @HiveField(3)
  String photoUrl;

  Drivers({this.id, this.names, this.lastNames, this.photoUrl});

  Drivers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    names = json['names'];
    lastNames = json['lastNames'];
    photoUrl = json['photoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['names'] = this.names;
    data['lastNames'] = this.lastNames;
    data['photoUrl'] = this.photoUrl;
    return data;
  }
}

@HiveType(typeId: 5)
class Device extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String mac;

  Device({this.id, this.mac});

  Device.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mac = json['mac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mac'] = this.mac;
    return data;
  }
}
