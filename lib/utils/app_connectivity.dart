import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recruit_iq/utils/App_Colors.dart';

showLog(String msg) {
  // msg = "";
  if(msg != "") {
    print(msg);
  }
}

Future<bool> checkConnectivity() async {
  List<ConnectivityResult> connectivityResult =
  await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    return false;
  } else if (connectivityResult.contains(ConnectivityResult.wifi) ||
      connectivityResult.contains( ConnectivityResult.mobile) ||
      connectivityResult.contains(ConnectivityResult.ethernet))  {
    return true;
  }
  return false;
}

// Future<bool> checkConnectivity() async {
//   ConnectivityResult connectivityResult =
//   await (Connectivity().checkConnectivity());
//   if(connectivityResult == ConnectivityResult.ethernet || connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
//     return true;
//   }else{
//     return false;
//   }
//   // if (connectivityResult.contains(ConnectivityResult.none)) {
//   //   return false;
//   // } else if (connectivityResult.contains(ConnectivityResult.wifi) ||
//   //     connectivityResult.contains( ConnectivityResult.mobile) ||
//   //     connectivityResult.contains(ConnectivityResult.ethernet))  {
//   //   return true;
//   // }
//   return false;
// }

showToast(msg) {
  Fluttertoast.showToast(
    msg: msg,
    textColor: AppColors.blackColor,
    backgroundColor: AppColors.whiteColor,
  );
}

