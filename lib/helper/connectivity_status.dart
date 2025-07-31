import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> connectivityStatus() async {
  bool connectivityStatus = false;
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

  if (connectivityResult.contains(ConnectivityResult.mobile)) {
    // Mobile network available.
    connectivityStatus = true;
  } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
    connectivityStatus = true;
    // Wi-fi is available.
    // Note for Android:
    // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
  } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
    connectivityStatus = true;
    // Ethernet connection available.
  } else if (connectivityResult.contains(ConnectivityResult.other)) {
    connectivityStatus = true;
    // Connected to a network which is not in the above mentioned networks.
  } else if (connectivityResult.contains(ConnectivityResult.none)) {
    connectivityStatus = false;
    // No available network types
  }
  return connectivityStatus;
}
