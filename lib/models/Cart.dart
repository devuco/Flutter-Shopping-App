import 'package:my_app/models/Product.dart' as productModel;

class Cart {
  bool? success;
  Data? data;

  Cart({this.success, this.data});

  Cart.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  List<Products>? products;
  num? netTotal;
  num? iV;

  Data({this.sId, this.userId, this.products, this.netTotal, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    netTotal = json['netTotal'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['netTotal'] = netTotal;
    data['__v'] = iV;
    return data;
  }
}

class Products {
  productModel.Data? product;
  num? quantity;
  num? total;
  String? sId;

  Products({this.product, this.quantity, this.total, this.sId});

  Products.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null
        ? productModel.Data.fromJson(json['product'])
        : null;
    quantity = json['quantity'];
    total = json['total'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['total'] = total;
    data['_id'] = sId;
    return data;
  }
}
