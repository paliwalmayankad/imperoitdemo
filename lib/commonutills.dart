import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CommonUtills{

  static String placeholder="assets/placeholder.png";


  static Future<bool> ConnectionStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static Widget CommonLoadingWidget(){
    return SpinKitThreeBounce(
      color: Colors.black,
      size: 30.0,);
  }
}