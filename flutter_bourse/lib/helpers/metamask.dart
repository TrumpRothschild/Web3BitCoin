import 'package:flutter/material.dart';
import 'package:flutter_bourse/Pages/miningMainPage.dart';
import 'package:flutter_bourse/http/log_utils.dart';
import 'package:flutter_bourse/js/js_helper_web.dart';
import 'package:flutter_web3/flutter_web3.dart';

import 'package:universal_html/js_util.dart';

import 'UserSharedPreferences.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 1; // 3 to  Connect to Rinkeby Test Network

  String currentAddress = '';

  int currentChain = -1;

  bool get isEnabled => ethereum != null;

  bool get isInOperatingChain => currentChain == operatingChain;

  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  BigInt yourCakeBalance = BigInt.zero;

  final JSHelper _jsHelper = JSHelper();
  Web3Provider? web3wc;

  Future<void> connect() async {
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) currentAddress = accs.first;

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }


  Future<void> connectWalletConnect() async {
    final wc = WalletConnectProvider.binance();
    await wc.connect();
    if (wc.connected) {
      currentAddress = wc.accounts.first;
      currentChain = 56;
      // wcConnected = true;
      // web3wc = Web3Provider.fromWalletConnect(wc);
    }
  }

  Future<void> connectBinance() async {
    final wc = WalletConnectProvider.binance();
    await wc.connect();
    if (wc.connected) {
      currentAddress = wc.accounts.first;
      currentChain = 56;
      // wcConnected = true;
      web3wc = Web3Provider.fromWalletConnect(wc);
    }
  }

  Future<void> connectMetaMask() async {
    // From RPC
    final wc = WalletConnectProvider.fromRpc(
      {1: 'https://mainnet.infura.io/v3/'},
      chainId: 1,
      network: 'metamask',
    );
    // await wc.connect();
    final web3provider = Web3Provider.fromWalletConnect(wc);

  }

  Future<void> connectCoinbase() async {
    // From Infura
    final infuraWc =
        WalletConnectProvider.fromInfura('https://foo.infura.io/v3/barbaz');
    final web3provider = Web3Provider.fromWalletConnect(infuraWc);
    await web3provider.getGasPrice(); // 5000000000
    await infuraWc.connect();
  }

  Future<void> connectWC() async {
    // From Infura
    final infuraWc =
        WalletConnectProvider.fromInfura('https://foo.infura.io/v3/barbaz');
    final web3provider = Web3Provider.fromWalletConnect(infuraWc);
    await web3provider.getGasPrice(); // 5000000000
    await infuraWc.connect();
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    // web3wc = null;
    notifyListeners();
  }

  init() {
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }
  }
}
