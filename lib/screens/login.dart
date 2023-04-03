import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_app/models/HomeProducts.dart';
import 'package:my_app/models/User.dart';
import 'package:my_app/screens/dashboard.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/service/api.dart';
import 'package:my_app/service/apiManager.dart';
import 'package:get/get.dart';
import 'package:my_app/utils/Constants.dart';
import 'package:my_app/widgets/customButton.dart';
import 'package:my_app/widgets/customTextInput.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? name = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    try {
      if (!GetUtils.isEmail(emailController.text)) {
        Get.snackbar("Invalid email", "Enter a valid email");
        return;
      }
      User? user = await ApiManager()
          .loginUser(emailController.text, passwordController.text);
      GetStorage box = GetStorage();
      await box.write("token", user?.data?.token);
      Constants.token = user?.data?.token ?? '';
      Get.off(const Dashboard());
    } on DioError catch (e) {
      print("eee" + e.response?.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 48),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 150,
                        width: 150,
                      ),
                      CustomTextInput(
                        loginController: emailController,
                        label: "email".tr,
                      ),
                      CustomTextInput(
                        loginController: passwordController,
                        label: "password".tr,
                      ),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                          child:
                              CustomButton(onPress: login, title: "login".tr))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
