class User {
  bool? success;
  Data? data;

  User({this.success, this.data});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? email;
  String? password;
  String? imageUri;
  List<Address>? address;
  int? iV;
  String? token;

  Data(
      {this.sId,
      this.name,
      this.email,
      this.password,
      this.imageUri,
      this.address,
      this.iV,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    imageUri = json['imageUri'];
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address!.add(Address.fromJson(v));
      });
    }
    iV = json['__v'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['imageUri'] = imageUri;
    if (address != null) {
      data['address'] = address!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    data['token'] = token;
    return data;
  }
}

class Address {
  String? houseNo;
  String? street;
  String? city;
  String? state;
  String? pincode;
  String? sId;

  Address(
      {this.houseNo,
      this.street,
      this.city,
      this.state,
      this.pincode,
      this.sId});

  Address.fromJson(Map<String, dynamic> json) {
    houseNo = json['houseNo'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['houseNo'] = houseNo;
    data['street'] = street;
    data['city'] = city;
    data['state'] = state;
    data['pincode'] = pincode;
    data['_id'] = sId;
    return data;
  }
}
