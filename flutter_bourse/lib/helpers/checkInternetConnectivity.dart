import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet {
  Future<bool> isInternetAvailable() async {
    var connectivityResult = (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else {
      return false;
    }
  }
}
