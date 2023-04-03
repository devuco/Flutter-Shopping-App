import 'package:dio/dio.dart';
import 'package:my_app/models/HomeProducts.dart';
import 'package:my_app/models/PostResponse.dart';
import 'package:my_app/models/Token.dart';
import 'package:my_app/models/Product.dart';
import 'package:my_app/models/User.dart';
import 'package:my_app/models/Cart.dart';
import 'package:my_app/service/api.dart';

class ApiManager {
  Future loginUser(String email, String password) async {
    try {
      Response response = await dio()
          .post('/login', data: {'email': email, 'password': password});
      return User.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response?.data);
    }
  }

  Future verifyToken() async {
    try {
      Response response = await dio().get("/token");
      return Token.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response as dynamic);
    }
  }

  Future getProducts() async {
    try {
      Response response = await dio().get('/products');
      return HomeProducts.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response as dynamic);
    }
  }

  Future getProductDetails(String productId) async {
    try {
      Response response = await dio().get("/products/$productId");
      return Product.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response as dynamic);
    }
  }

  Future addToCart(String? productId) async {
    try {
      Response response =
          await dio().post("/cart", data: {"product": productId});
      return PostResponse.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response as dynamic);
    }
  }

  Future getCart() async {
    try {
      Response response = await dio().get("/cart");
      return Cart.fromJson(response.data);
    } on DioError catch (e) {
      return Future.error(e.response as dynamic);
    }
  }
}
