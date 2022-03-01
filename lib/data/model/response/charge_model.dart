class ChargeResponseModel {
  num balance;
  String code;
  dynamic metadata;
  bool isPreferencial;
  String status;
  num transactionAmount;
  ChargeResponseModel(
      {this.balance,
        this.code,
        this.metadata,
        this.isPreferencial,
        this.status,
        this.transactionAmount});

  ChargeResponseModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'] as num;
    code = json['code'];
    metadata = json['metadata'];
    isPreferencial = json['isPreferencial'];
    status = json['status'];
    transactionAmount = json['transactionAmount'] as num;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['code'] = this.code;
    data['metadata'] = this.metadata;
    data['isPreferencial'] = this.isPreferencial;
    data['status'] = this.status;
    data['transactionAmount'] = this.transactionAmount;

    return data;
  }
}
