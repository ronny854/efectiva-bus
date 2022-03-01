class CardTransaction {
  String id;
  int amount;
  Card card;
  String created;

  CardTransaction({
    this.id,
    this.amount,
    this.card,
    this.created,
  });

  CardTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    card = json['card'] != null ? new Card.fromJson(json['card']) : null;
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['amount'] = this.amount;
    if (this.card != null) {
      data['card'] = this.card.toJson();
    }
    data['created'] = this.created;
    return data;
  }
}

class Card {
  bool isPreferencial;
  String code;
  Metadata metadata;

  Card({
    this.isPreferencial,
    this.code,
    this.metadata,
  });

  Card.fromJson(Map<String, dynamic> json) {

    code = json['code'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPreferencial'] = this.isPreferencial;
    data['code'] = this.code;
    if (this.metadata != null) {
      data['metadata'] = this.metadata.toJson();
    }

    return data;
  }
}

class Metadata {
  String names;

  Metadata({
    this.names,
  });

  Metadata.fromJson(Map<String, dynamic> json) {
    names = json['names'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['names'] = this.names;
    return data;
  }
}
