import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/getApiToken.dart';
import 'package:flutter_bourse/Pages/account_login_page.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_bourse/http/data_utils.dart';
import 'package:flutter_bourse/utils/jh_progress_hud.dart';
import 'package:flutter_bourse/utils/jh_storage_utils.dart';
import 'package:flutter_bourse/utils/loading_animation.dart';
import 'package:flutter_bourse/widgets/Recharge/flutter_web3_provider/ethers.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helpers/metamask.dart';
import 'package:flutter_web3/flutter_web3.dart';

import 'package:http/http.dart' as http;


class MetaMaskPage extends StatefulWidget {
  const MetaMaskPage({Key? key}) : super(key: key);

  @override
  State<MetaMaskPage> createState() => _MetaMaskPagePageState();
}

class _MetaMaskPagePageState extends State<MetaMaskPage> {

  BigInt yourCakeBalance = BigInt.zero;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetaMaskProvider()..init(),
      builder: (context, child) {
        return Container(
          color: Color.fromARGB(255, 244, 244, 244),
          child: Stack(
            children: [
              Consumer<MetaMaskProvider>(
                builder: (context, provider, child) {
                  final prefs = SharedPreferences.getInstance();
                  String ConnectionStatus = '';
                  bool isConnected = UserSharedPreferences.getPrivateAddress().toString().length >= 14 ? true : false;
                  String text = translate('home.Wallet');
                  bool isRedirecting = false;
                  if (provider.isConnected && provider.isInOperatingChain) {
                    setPreferences(provider.currentAddress);
                    UserSharedPreferences.setPrivateAddress(provider.currentAddress);
                    text = translate('home.Address') +
                        UserSharedPreferences.getPrivateAddress().toString();
                      // Here you can write your code
                    // getLogin(provider.currentAddress);

                    ConnectionStatus = translate('home.Connected');
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      isRedirecting = false;
                      ConnectionStatus = translate('home.Redirecting');
                      setState(() {});
                      Reload();
                    });
                  } else if (provider.isConnected &&
                      !provider.isInOperatingChain) {
                    text = translate('home.Wrong') +
                        '${MetaMaskProvider.operatingChain}';
                    setPreferences('');
                  } else if (provider.isEnabled) {
                    return Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        !isConnected
                            ? CupertinoButton(
                                onPressed: () =>
                                    context.read<MetaMaskProvider>().connect(),
                                color: Color.fromARGB(255, 244, 244, 244),
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 15,
                                            right: 15),
                                        height: 50,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                ))),
                                            onPressed: () {
                                              LoadingProgress.ShowLoading(context);
                                              context.read<MetaMaskProvider>().connect();
                                              setState(() {
                                                isRedirecting = true;

                                                // Phoenix.rebirth(context);
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Metamask',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                Image.asset(
                                                  'assets/images/MetaMask_fox.png',
                                                  width: 30,
                                                  height: 30,
                                                )
                                              ],
                                            ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 15,
                                            right: 15),
                                        height: 50,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                ))),
                                            onPressed: () {
                                              LoadingProgress.ShowLoading(context);
                                              context.read<MetaMaskProvider>().connect();
                                              // Navigator.pop(context);
                                              setState(() {
                                                isRedirecting = true;
                                                // text = context.read<MetaMaskProvider>().currentAddress;
                                                // Phoenix.rebirth(context);
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Trust Wallet',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                Image.asset(
                                                  'assets/images/TWT.png',
                                                  width: 30,
                                                  height: 30,
                                                )
                                              ],
                                            ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 15,
                                            right: 15),
                                        height: 50,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                ))),
                                            onPressed: () {
                                              LoadingProgress.ShowLoading(context);
                                              context.read<MetaMaskProvider>().connect();
                                              // Navigator.pop(context);
                                              setState(() {
                                                isRedirecting = true;
                                                // text = context.read<MetaMaskProvider>().currentAddress;
                                                // Phoenix.rebirth(context);
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Coinbase',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                Image.asset(
                                                  'assets/images/coinbase.png',
                                                  width: 30,
                                                  height: 30,
                                                )
                                              ],
                                            ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 15,
                                            right: 15),
                                        height: 50,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(ColorConstants.AppCoinbaseBlueColor),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(25)),
                                                ))),
                                            onPressed: () {
                                              LoadingProgress.ShowLoading(context);
                                              context.read<MetaMaskProvider>().connectWalletConnect();
                                              // Navigator.pop(context);
                                              setState(() {
                                                isRedirecting = true;
                                                // text = context.read<MetaMaskProvider>().currentAddress;
                                                // Phoenix.rebirth(context);
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Wallet Connect',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                Image.asset(
                                                  'assets/images/walletconnect.png',
                                                  width: 30,
                                                  height: 30,
                                                )
                                              ],
                                            ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: 12, bottom: 12, left: 15, right: 15),
                                        height: 50,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                foregroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    ColorConstants.AppCoinbaseBlueColor),
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(
                                                    ColorConstants.AppCoinbaseBlueColor),
                                                shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.all(Radius.circular(25)),
                                                    ))),
                                            onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => AccountLoginPage()),
                                                  );
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  translate('home.Login')+"/"+translate('home.Register'),
                                                  style: TextStyle(
                                                      color: Colors.white, fontSize: 18),
                                                )
                                              ],
                                            ))),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    );
                  } else {
                    // UserSharedPreferences.setPrivateAddress('');
                    text = translate('home.websspuported');
                  }
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                top: 12, bottom: 12, left: 15, right: 15),
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ))),
                                onPressed: () {
                                  LoadingProgress.ShowLoading(context);
                                  context.read<MetaMaskProvider>().connect();
                                  setState(() {
                                    text = context.read<MetaMaskProvider>().currentAddress;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/MetaMask_fox.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      'Metamask',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),

                                  ],
                                ))),
                        Container(
                            margin: EdgeInsets.only(
                                top: 12, bottom: 12, left: 15, right: 15),
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ))),
                                onPressed: () {
                                  LoadingProgress.ShowLoading(context);
                                  context.read<MetaMaskProvider>().connect();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/TWT.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      'Trust Wallet',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),

                                  ],
                                ))),
                        Container(
                            margin: EdgeInsets.only(
                                top: 12, bottom: 12, left: 15, right: 15),
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ))),
                                onPressed: () {
                                  LoadingProgress.ShowLoading(context);
                                  context.read<MetaMaskProvider>().connect();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/coinbase.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      'Coinbase',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),

                                  ],
                                ))),
                        Container(
                            margin: EdgeInsets.only(
                                top: 12, bottom: 12, left: 15, right: 15),
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            ColorConstants.AppCoinbaseBlueColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ))),
                                onPressed: () {
                                  LoadingProgress.ShowLoading(context);
                                  context.read<MetaMaskProvider>().connectWalletConnect();
                                  Navigator.pop(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/walletconnect.png',
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      'Wallet Connect',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),

                                  ],
                                ))),
                        Container(
                            margin: EdgeInsets.only(
                                top: 12, bottom: 12, left: 15, right: 15),
                            height: 70,
                            width: 200,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorConstants.AppCoinbaseBlueColor),
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        ColorConstants.AppCoinbaseBlueColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                        ))),
                                onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => AccountLoginPage()),
                                      );
                                  // Navigator.pop(context);
                                  // Reload();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      translate('home.Login')+"/"+translate('home.Register'),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      maxLines: 2,
                                    )
                                  ],
                                ))),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }


  Reload() async {
    // Obtain shared preferences.
    Future.delayed(const Duration(milliseconds: 100), () {
      // Here you can write your code
      setState(() {
        Phoenix.rebirth(context);
      });
    });
  }


  setPreferences(String privateAddress) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    UserSharedPreferences.setPrivateAddress(privateAddress);
    await prefs.setString('address', privateAddress);
  }

  setPreferencesToken(String privateToken) async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    UserSharedPreferences.setPrivateToken(privateToken);

    await prefs.setString('Token', privateToken);
  }

  setLoginType(int privateLanuage) async {
    // Obtain shared preferences.
    setState(() async {

      UserSharedPreferences.setLoginType(privateLanuage);

    });
  }
}
