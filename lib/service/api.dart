import 'package:dio/dio.dart';
import 'package:my_app/utils/Constants.dart';

Dio dio() => Dio(BaseOptions(baseUrl: Constants.baseUrl, headers: {
      "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      "Access-Control-Allow-Credentials":
          true, // Required for cookies, authorization headers with HTTPS
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
      "token": Constants.token
    }));
