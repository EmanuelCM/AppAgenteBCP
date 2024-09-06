import 'dart:io';

class Envioronment {
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.1.15:300/api'
      : 'http://localhost:3000/api';
  static String socketUrl =
      Platform.isAndroid ? 'http://192.168.1.15:300' : 'htpp://localhost:3000';
}
