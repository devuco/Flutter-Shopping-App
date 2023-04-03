class Product {
  bool? success;
  Data? data;

  Product({this.success, this.data});

  Product.fromJson(Map<String, dynamic> json) {
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
  String? image;
  String? name;
  Category? category;
  String? description;
  num? price;
  num? stock;
  Category? company;
  num? discount;
  num? discountedPrice;
  Rating? rating;
  num? avgRating;
  num? totalRatings;
  String? review;
  String? color;
  num? iV;
  bool? isSaved;

  Data(
      {this.sId,
      this.image,
      this.name,
      this.category,
      this.description,
      this.price,
      this.stock,
      this.company,
      this.discount,
      this.discountedPrice,
      this.rating,
      this.avgRating,
      this.totalRatings,
      this.review,
      this.color,
      this.iV,
      this.isSaved});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    image = json['image'];
    name = json['name'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    company =
        json['company'] != null ? Category.fromJson(json['company']) : null;
    discount = json['discount'];
    discountedPrice = json['discountedPrice'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    avgRating = json['avgRating'];
    totalRatings = json['totalRatings'];
    review = json['review'];
    color = json['color'];
    iV = json['__v'];
    isSaved = json['isSaved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['image'] = image;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['description'] = description;
    data['price'] = price;
    data['stock'] = stock;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['discount'] = discount;
    data['discountedPrice'] = discountedPrice;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['avgRating'] = avgRating;
    data['totalRatings'] = totalRatings;
    data['review'] = review;
    data['color'] = color;
    data['__v'] = iV;
    data['isSaved'] = isSaved;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? image;
  num? iV;

  Category({this.sId, this.name, this.image, this.iV});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['__v'] = iV;
    return data;
  }
}

class Rating {
  num? oneStar;
  num? twoStar;
  num? threeStar;
  num? fourStar;
  num? fiveStar;
  String? sId;

  Rating(
      {this.oneStar,
      this.twoStar,
      this.threeStar,
      this.fourStar,
      this.fiveStar,
      this.sId});

  Rating.fromJson(Map<String, dynamic> json) {
    oneStar = json['oneStar'];
    twoStar = json['twoStar'];
    threeStar = json['threeStar'];
    fourStar = json['fourStar'];
    fiveStar = json['fiveStar'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oneStar'] = oneStar;
    data['twoStar'] = twoStar;
    data['threeStar'] = threeStar;
    data['fourStar'] = fourStar;
    data['fiveStar'] = fiveStar;
    data['_id'] = sId;
    return data;
  }
}
