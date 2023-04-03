import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {'login': 'Login', 'email': 'email', 'password': 'password'},
        'hi_IN': {
          'login': 'लॉग इन करें',
          'email': 'ईमेल',
          'password': 'पासवर्ड'
        }
      };
}
