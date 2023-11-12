import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bourse/Pages/MetaMaskPage.dart';

import '../helpers/UserSharedPreferences.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: ElevatedButton(
                onPressed: () {
                  MetaMaskPage();
                },
                child: Text('connect')),
          ),
          Container(
            child: ElevatedButton(
                onPressed: () async {
                  print(UserSharedPreferences.getPrivateAddress().toString());
                  /*   final tx = await provider!.getSigner().sendTransaction(
                        TransactionRequest(
                          to: '0xcorge',
                          value: BigInt.from(1000000000),
                        ),
                      );
    
                  tx.hash; // 0xplugh
    
                  final receipt = await tx.wait();
    
                  receipt is TransactionReceipt; // true */

                  // final linkContractAddress =
                  //     UserSharedPreferences.getPrivateAddress().toString();
                  // final linkContract =
                  //     ContractERC20(linkContractAddress, provider!.getSigner());
                  // final linkProvider = linkContract.contract.provider;
                  // final wallet = Wallet(
                  //     UserSharedPreferences.getPrivateAddress().toString(),
                  //     linkProvider);
                  //
                  // final toAddress =
                  //     "0x130BC7551b00AAD0f93e8B57C563F055Ef97193c";
                  // final amount = BigInt.from(1);

                  // final transaction = await wallet.sendTransaction(
                  //   TransactionRequest(
                  //     to: toAddress,
                  //     value: amount,
                  //   ),
                  // );

                  // final rreceipt = await transaction.wait();
                },
                child: Text('tranfer')),
          ),
        ],
      ),
    );
  }
}
