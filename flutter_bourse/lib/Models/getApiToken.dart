import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../helpers/UserSharedPreferences.dart';

// class GetApiToken {
//   String? msg;
//   int? code;
//   String? token;
//   String? wsToken;
//
//   // Future<GetApiToken> GetToken(String user) async {
//   //   String privateAddress = '';
//   //   Uri tokenurl =
//   //       Uri.parse('${GetServerPath().serverIP}/mobile/userInfo/login');
//   //
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   privateAddress = UserSharedPreferences.getPrivateAddress().toString();
//   //   if (privateAddress.toString().length >= 40) {
//   //     // Map data = {'userName': '0xb85e08c60F7fdA76586A6b64350B22200956aDFA'};
//   //     Map data = {'userName': privateAddress};
//   //     var body = json.encode(data);
//   //
//   //     final res = await http.post(tokenurl,
//   //         headers: {"Content-Type": "application/json"}, body: body);
//   //
//   //     var tokenData = jsonDecode(res.body);
//   //     final Map<String, dynamic> jsonResult = jsonDecode(res.body);
//   //
//   //     var jsonData = jsonDecode(res.body);
//   //
//   //     GetApiToken apiTokeResult = GetApiToken.fromJson(jsonResult);
//   //     log(res.statusCode.toString());
//   //     log(res.body.toString());
//   //     UserSharedPreferences.setPrivateToken(apiTokeResult.token!);
//   //     await UserSharedPreferences.setWsToken(apiTokeResult.wsToken!);
//   //     return apiTokeResult;
//   //   } else {
//   //     print('No Address found in GetAPiToken');
//   //     return GetApiToken();
//   //   }
//   // }
//
//   GetApiToken({this.msg, this.code, this.token});
//
//   GetApiToken.fromJson(Map<String, dynamic> json) {
//
//     code = json['code'];
//     token = json['data']['token'];
//     wsToken = json['wsToken'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//
//     data['code'] = this.code;
//     data['data']['token'] = this.token;
//     data['wsToken'] = this.wsToken;
//     return data;
//   }
// }

class GetApiToken {
  int? total;

  TokenData? data;
  int? code;
  GetApiToken({this.total,  this.data, this.code});

  GetApiToken.fromJson(Map<String, dynamic> json) {
    total = json['total'];

    data = json['data'] != null ? new TokenData.fromJson(json['data']) : null;
    code = json['code'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['code'] = this.code;

    return data;
  }
}

class TokenData {
  String? token;

  TokenData({this.token});

  TokenData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}