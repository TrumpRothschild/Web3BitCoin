import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/savings_model.dart';
import 'package:flutter_bourse/Models/SavingsAccountModel.dart';
import 'package:flutter_bourse/Models/User/user_model.dart';
import 'package:flutter_bourse/Pages/account_register_page.dart';
import 'package:flutter_bourse/Pages/change_transaction_password.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/Pages/transaction_history.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/utils/utils.dart';
import 'package:flutter_bourse/widgets/Recharge/account_recharge_views.dart';
import 'package:flutter_bourse/widgets/Recharge/recharge_views.dart';
import 'package:flutter_bourse/widgets/UserCenter/generated/assets.dart';
import 'package:flutter_bourse/widgets/UserCenter/json/shortcut_list.dart';
import 'package:flutter_bourse/widgets/UserCenter/widgets/custom_list_tile.dart';
import 'package:flutter_bourse/widgets/UserCenter/utils/iconly/iconly_bold.dart';
import 'package:flutter_bourse/widgets/UserCenter/utils/styles.dart';
import 'package:flutter_bourse/widgets/Withdraw/withdraw_view.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bourse/Models/getApiToken.dart';

class Profile extends StatefulWidget {

  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  UserModel? userModel = UserModel();
 var rowsList = <UserList?>[];
   SavingsOrdersRows? ordersList = SavingsOrdersRows();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSavingsApi();
  }
  void getSavingsApi() async {
    rowsList.clear();
  Uri url = Uri.parse(
      '${APIs.apiPrefix}/web/fwallet/list');
    Map dataUrl = {'walletType':'0'};
    var bodyUrl = json.encode(dataUrl);
  final response = await http.post(url, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${UserSharedPreferences.getPrivateToken()}',
    "lang":UserSharedPreferences.getPrivateLang().toString()
  },body: bodyUrl);

  final Map<String, dynamic> jsonResult = jsonDecode(response.body);
  if (jsonResult['code'] == 200) {
    userModel = UserModel.fromJson(jsonResult);
    for(var item in userModel!.data!.list!) {
      rowsList.add(item);
    }
  }
  setState(() {
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        centerTitle: true,
        title: Text(translate('home.UserCenter'), style: TextStyle(color: Colors.black, fontSize: 18),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          const Gap(20),
          Stack(
            children: [
              Container(
                height: 300,
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF3F6F8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(60),
                      Center(
                          child: Text((rowsList.isNotEmpty) ? "\$ "+userModel!.data!.totalAmount!.toString() : "0",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold))),
                      const Gap(10),
                      Text(translate('home.CoinValue'),
                          style:
                              TextStyle(color: Colors.grey)),
                      const Gap(25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: profilesShortcutList.map<Widget>((e) {
                          return GestureDetector(
                            onTap: (){
                              if (e['index'] == '1') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TransactionHistory()),
                                );
                              } else if (e['index'] == '2') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const ChangeTransactionPassword()));
                              } else if (e['index'] == '3') {
                                if (UserSharedPreferences.getLoginType() == 2) {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AccountRechargeView()),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RechargeViews(savingsData: SavingRows(),)),
                                  );
                                }

                              }else if (e['index'] == '4') {

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const WithdrawView(walletType: '0')));
                              }
                            },
                            child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                            padding: const EdgeInsets.all(13),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(e['icon'], color: e['color']),
                          ),);
                        }).toList(),
                      ),
                      const Gap(10)
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                right: 30,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstants.AppCoinbaseBlueColor,
                  ),
                  child: Transform.scale(
                    scale: 0.55,
                    child: Image.asset(Assets.dash),
                  ),
                ),
              )
            ],
          ),
          const Gap(35),
          CustomListTile(
              icon: IconlyBold.User,
              color:  ColorConstants.AppCoinbaseBlueColor,
              title: "BTC", context: context,money: (rowsList.isNotEmpty) ? rowsList[0]!.balance.toString() : "0",imageString: Assets.btc,),
          CustomListTile(
              icon: IconlyBold.Shield_Done,
              color: const Color(0xFF229e76),
              title: "ETH", context: context,money: (rowsList.isNotEmpty) ? rowsList[6]!.balance.toString() : "0",imageString: Assets.eth),
          CustomListTile(
              icon: IconlyBold.Message,
              color: const Color(0xFFe17a0a),
              title: "USDT-TRC20", context: context,money: (rowsList.isNotEmpty) ? rowsList[1]!.balance.toString() : "0",imageString: Assets.usdt),
          CustomListTile(
              icon: IconlyBold.Document,
              color: const Color(0xFF064c6d),
              title: "USDT-ERC20", context: context,money:  (rowsList.isNotEmpty) ? rowsList[2]!.balance.toString() : "0",imageString: Assets.usdt),
          CustomListTile(
              icon: IconlyBold.Document,
              color: const Color(0xFF064c6d),
              title: "Doge", context: context,money: (rowsList.isNotEmpty) ? rowsList[3]!.balance.toString() : "0",imageString: Assets.doge),
          CustomListTile(
              icon: IconlyBold.Document,
              color: const Color(0xFF064c6d),
              title: "USDC-ERC20", context: context,money: (rowsList.isNotEmpty) ? rowsList[4]!.balance.toString() : "0",imageString: 'assets/assets/images/usdc.png'),
          CustomListTile(
              icon: IconlyBold.Document,
              color: const Color(0xFF064c6d),
              title: "USDC-TRC20", context: context,money: (rowsList.isNotEmpty) ? rowsList[5]!.balance.toString() : "0",imageString: 'assets/assets/images/usdc.png'),
        ],
      ),
    );
  }
}

