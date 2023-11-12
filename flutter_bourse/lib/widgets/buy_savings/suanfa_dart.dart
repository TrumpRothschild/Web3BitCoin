import 'package:flutter/material.dart';
import 'package:flutter_bourse/utils/utils.dart';

class SuanFaDart extends StatefulWidget {
  const SuanFaDart({Key? key}) : super(key: key);

  @override
  State<SuanFaDart> createState() => _SuanFaDartState();
}

class _SuanFaDartState extends State<SuanFaDart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(0))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    decoration:  BoxDecoration(
                      border: new Border.all(color: Colors.grey,width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "SHA256"+ " " + translate('home.algorithm'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "42.59 Eh/s",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 10),
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('assets/images/bitcoin.png',width: 50,height: 50,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      "BTC",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "0.00000346",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 0),
                                    margin: EdgeInsets.only(right: 0),
                                    child: Text(
                                      "BTC/T",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 10),
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('assets/images/bitcoin-cash.png',width: 50,height: 50,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      "BCH",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left:0,top: 10,right: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "0.00062145",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 0),
                                    margin: EdgeInsets.only(right: 0),
                                    child: Text(
                                      "BCH/T",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    decoration:  BoxDecoration(
                      border: new Border.all(color: Colors.grey,width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "Scrypt" +" "+ translate('home.algorithm'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "63.85 Th/s",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 10),
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('assets/images/doge.png',width: 50,height: 50,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      "Doge",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "0.01347",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 0),
                                    margin: EdgeInsets.only(right: 0),
                                    child: Text(
                                      "Doge/G",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 10),
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('assets/images/Ltccoin.png',width: 50,height: 50,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      "LTC",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "0.01347",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 0),
                                    margin: EdgeInsets.only(right: 0),
                                    child: Text(
                                      "LTC/G",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    decoration:  BoxDecoration(
                      border: new Border.all(color: Colors.grey,width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "Etchash"+ " "+ translate('home.algorithm'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "6.67 Th/s",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 10),
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('assets/images/ethereum-classic.png',width: 50,height: 50,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      "ETC",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "0.00010729",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 0),
                                    margin: EdgeInsets.only(right: 0),
                                    child: Text(
                                      "ETC/M",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    decoration:  BoxDecoration(
                      border: new Border.all(color: Colors.grey,width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "Equihash"+ " "+ translate('home.algorithm'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                translate('home.PayType'),
                                // algorithm!.algorithmPower!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 10),
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('assets/images/Zcash-ZEC-.png',width: 50,height: 50,),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 6,top: 10),
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // translate('home.Timelimit'),
                                      "ZEC",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "",
                                      // algorithm!.computingPower!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 0),
                                    margin: EdgeInsets.only(right: 0),
                                    child: Text(
                                      "ZEC/K",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(15),
                    decoration:  BoxDecoration(
                      border: new Border.all(color: Colors.grey,width: 0.5),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                          bottomLeft: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                // translate('home.PayType'),
                                "Ethash"+ " "+ translate('home.algorithm'),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                translate('home.PayType'),
                                // algorithm!.algorithmPower!,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 10),
                                    width: 50,
                                    height: 50,
                                    child: Image.asset('assets/images/ethereum-classic.png',width: 50,height: 50,),
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10,right: 8),
                                    margin: EdgeInsets.only(right: 8),
                                    child: Text(
                                      "",
                                      // algorithm!.computingPower!,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ),

                                ],
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
