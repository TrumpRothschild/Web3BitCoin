import 'package:flutter_bourse/Pages/MetaMaskPage.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/data_utils.dart';

import 'package:flutter_bourse/utils/jh_storage_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bourse/http/intercept.dart';
import 'package:sp_util/sp_util.dart';

///MetaMask
class MetaMaskController extends GetxController with GetSingleTickerProviderStateMixin {

 late String tokenAuth = "";

 @override
 void onInit() {
  super.onInit();

 }
 void getLogin() {
  DataUtils.login({"userName":UserSharedPreferences.getPrivateAddress().toString()},success: (res)  {
   print("返回参数${res}");
   // setToken(res['token']);
   // JhStorageUtils.saveString('refreshToken', res['token']);


   // tokenString = res['token'];
   // tokenAuth = res['token'];
   // setPreferencesToken(res['token']);
   // var token = UserSharedPreferences.getPrivateToken().toString();
   // late UserInfoBean infoBean;
   // UserInfoBean(token: res['token']);

  });
 }

}

class UserInfoBean {
 String token;

 UserInfoBean({required this.token});
}

