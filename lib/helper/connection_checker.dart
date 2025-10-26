import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

Future<bool> hasSecureInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  }
  try {
    final response = await http.get(Uri.parse('https://google.com'));
    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}