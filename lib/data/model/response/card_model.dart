class CardModel {
  String code;
  dynamic metadata;
  bool isPreferencial;
  num balance;
  String preference;
  CardModel(
      {this.balance,
        this.code,
        this.metadata,
        this.isPreferencial,
        this.preference});

  CardModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    code = json['code'];
    metadata = json['metadata'];
    isPreferencial = json['isPreferencial'];
    preference = json['preference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['code'] = this.code;
    data['metadata'] = this.metadata;
    data['isPreferencial'] = this.isPreferencial;
    data['preference'] = this.preference;

    return data;
  }

}

