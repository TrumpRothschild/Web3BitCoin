import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/ActingModel/poolInfo_model.dart';
import 'package:flutter_bourse/Models/HomeModel/select_mining_mode.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MiningPoolDataWidget extends StatefulWidget {
  MiningPoolDataWidget({Key? key}) : super(key: key);

  @override
  State<MiningPoolDataWidget> createState() => _MiningPoolDataWidgetState();
}

class _MiningPoolDataWidgetState extends State<MiningPoolDataWidget> {
  bool inverter = false;

  final _headerStyle = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w400);
  final _contentStyleHeader = const TextStyle(
      color: Color.fromARGB(255, 0, 0, 0),
      fontSize: 14,
      fontWeight: FontWeight.w700);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  PoolInfoModel? poolInfoModel;
  double accountBalance = 0.0000;
  double? usdtBalance = 0.0000;
  double? totalPoolEthBalance = 0.000000;
  double totalEthBalance = 0.0000;
  double ethBalance = 0.0000;
  SelectMiningModel? model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // selectMining();
  }
  void selectMining() async {
    var privateAddress = '';
    Uri tokenurl =
    Uri.parse('${APIs.apiPrefix}/index/loginWallet');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateAddress = UserSharedPreferences.getPrivateAddress().toString();
    Map data = {'address':privateAddress,'invite':"123456"};
    var body = json.encode(data);
    final res = await http.post(tokenurl,
        headers: {"Content-Type": "application/json"}, body: body);
    var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResultLogin = jsonDecode(res.body);
    GetApiToken apiTokeResult = GetApiToken.fromJson(jsonResultLogin);

    Uri miningUrl = Uri.parse('${APIs.apiPrefix}/index/selectMining');
    final resMining = await http.post(miningUrl,
        headers: {"Content-Type": "application/json",'Accept': 'application/json','Authorization': 'Bearer ${apiTokeResult.data!.token}',});

    final Map<String, dynamic> jsonResult = jsonDecode(resMining.body);
    if (jsonResult['code'] == 0) {
      model = SelectMiningModel.fromJson(jsonResult);
      totalPoolEthBalance =  model!.data![0].total!.toDouble();
      totalEthBalance = model!.data![0].totalOutput!.toDouble();
      ethBalance = model!.data![0].exchange!.toDouble();
      accountBalance = model!.data![0].banlanceAccount!.toDouble();
      usdtBalance = model!.data![0].walletAccount!;
      setState(() {

      });
    } else {
      showToast("无网络");
    }
  }

  @override
  Widget build(BuildContext context) {
    // networkMiningData();
    return Container(
      margin: EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          )),
      child: Column(
        children: [
          SizedBox(
            height: 6,
          ),
          getMiningData(translate('home.TotalOutput'),(totalEthBalance == 0) ? "0" : "${totalEthBalance}"),
          getMiningData(translate('home.ValidNode'), (model!.data![0].validNode == null) ? "0" : "${model!.data![0].validNode}"),
          getMiningData(translate('home.Participant'), (model!.data![0].participant == null) ? "0" : "${model!.data![0].participant}"),
          getMiningData(translate('home.UserIncome'), (model!.data![0].userRevenue == null) ? "0" : "${model!.data![0].userRevenue}"),
        ],
      ),
    );
  }

  Widget getMiningData(String name, String value) {
    return Container(
      margin: EdgeInsets.only(top: 6, bottom: 12, left: 6, right: 6),
      padding: EdgeInsets.only(left: 18, right: 18, top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              name,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
