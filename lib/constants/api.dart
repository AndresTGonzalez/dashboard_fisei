import 'package:dashboard_fisei/utils/security.dart';

class API {
  // ignore: constant_identifier_names
  static const String BASE_URL = 'https://hatunsoft.uta.edu.ec:8080/api/';
  // static const String BASE_URL = 'http://146.190.51.141/api/';

  static Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Access-Control-Allow-Origin': '*',
    'Authorization': Security.token,
  };
}
