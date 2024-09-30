import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService{

  static Future<bool> isConnectedToInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }


  static Future<bool> get hasInternet async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

}