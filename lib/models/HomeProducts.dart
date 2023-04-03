class HomeProducts {
  bool? success;
  List<Data>? data;

  HomeProducts({this.success, this.data});

  HomeProducts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? image;
  String? name;
  num? price;
  num? discount;
  num? discountedPrice;
  String? color;
  bool? isSaved;

  Data(
      {this.sId,
      this.image,
      this.name,
      this.price,
      this.discount,
      this.discountedPrice,
      this.color,
      this.isSaved});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    name = json['name'];
    price = json['price'];
    discount = json['discount'];
    discountedPrice = json['discountedPrice'];
    color = json['color'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['name'] = name;
    data['price'] = price;
    data['discount'] = discount;
    data['discountedPrice'] = discountedPrice;
    data['color'] = color;
    data['isSaved'] = isSaved;
    return data;
  }
}
