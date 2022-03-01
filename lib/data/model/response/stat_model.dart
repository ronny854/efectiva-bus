class StatModel {
  num totalPreference;
  num totalNoPreference;
  num preferencialAmount;
  num noPreferencialAmount;
  num total;
  num rechargesAmount;
  num rechargesCount;
  StatModel(
      {this.totalPreference,
        this.totalNoPreference,
        this.preferencialAmount,
        this.noPreferencialAmount,
        this.total, this.rechargesAmount, this.rechargesCount});

  StatModel.fromJson(Map<String, dynamic> json) {
    totalPreference = json['totalPreference'];
    totalNoPreference = json['totalNoPreference'];
    preferencialAmount = json['preferencialAmount'];
    noPreferencialAmount = json['noPreferencialAmount'];
    total = json['total'];
    rechargesAmount = json['rechargesAmount'];
    rechargesCount = json['rechargesCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPreference'] = this.totalPreference;
    data['totalNoPreference'] = this.totalNoPreference;
    data['preferencialAmount'] = this.preferencialAmount;
    data['noPreferencialAmount'] = this.noPreferencialAmount;
    data['total'] = this.total;
    data['rechargesAmount'] = this.rechargesAmount;
    data['rechargesCount'] = this.rechargesCount;
    return data;
  }

}

