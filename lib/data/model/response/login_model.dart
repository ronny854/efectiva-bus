class LoginResponse {
  String token;
  UserData userData;

  LoginResponse({this.token, this.userData});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.userData != null) {
      data['userData'] = this.userData.toJson();
    }
    return data;
  }
}

class UserData {
  String uid;
  String names;
  String lastNames;
  String displayName;
  String email;
  String photoURL;

  UserData(
      {this.uid,
        this.names,
        this.lastNames,
        this.displayName,
        this.email,
        this.photoURL});

  UserData.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    names = json['names'];
    lastNames = json['lastNames'];
    displayName = json['displayName'];
    email = json['email'];
    photoURL = json['photoURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['names'] = this.names;
    data['lastNames'] = this.lastNames;
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoURL'] = this.photoURL;
    return data;
  }
}
