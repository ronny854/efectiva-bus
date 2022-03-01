class ChargeRequestModel {
  String code;
  String operatorId;
  String busId;
  String routeId;
  num amountToDebit;
  ChargeRequestModel(
      {this.code,
        this.operatorId,
        this.busId,
        this.routeId,
        this.amountToDebit});

  ChargeRequestModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    operatorId = json['operatorId'];
    busId = json['busId'];
    routeId = json['routeId'];
    amountToDebit = json['amountToDebit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['operatorId'] = this.operatorId;
    data['busId'] = this.busId;
    data['routeId'] = this.routeId;
    data['amountToDebit'] = this.amountToDebit;

    return data;
  }
}
