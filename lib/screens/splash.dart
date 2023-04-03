import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:my_app/screens/dashboard.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/login.dart';
import 'package:my_app/service/apiManager.dart';
import 'package:my_app/utils/Constants.dart';
import 'package:my_app/widgets/loader.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoading = false;

  @override
  void initState() {
    final token = GetStorage().read('token');
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      if (token != null) {
        Constants.token = token;
        setState(() {
          isLoading = true;
        });
        try {
          await ApiManager().verifyToken();
          Get.off(const Dashboard(),
              transition: Transition.rightToLeft,
              duration: const Duration(seconds: 1));
        } catch (e) {
          Get.off(const Login(),
              transition: Transition.downToUp,
              duration: const Duration(seconds: 1));
        }
      } else {
        Get.off(const Login(),
            transition: Transition.downToUp,
            duration: const Duration(seconds: 1));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png'),
          Loader(
            isLoading: isLoading,
            backgroundColor: Colors.orange,
          )
        ],
      ),
    );
  }
}
