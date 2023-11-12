import 'package:flutter/material.dart';
import 'package:flutter_bourse/Pages/MetaMaskPage.dart';
import 'package:flutter_bourse/Pages/colors.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ConnectWalletMessagePage extends StatefulWidget {
  ConnectWalletMessagePage({Key? key}) : super(key: key);

  @override
  State<ConnectWalletMessagePage> createState() =>
      _ConnectWalletMessagePageState();
}

class _ConnectWalletMessagePageState extends State<ConnectWalletMessagePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRect(
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(80), // Image radius
                    child: Image.asset('assets/images/warning.png',
                        fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      translate('home.WarmReminder'),
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      translate('home.PleaseVisit'),
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 12, top: 6),
                      child: Text(
                        translate('home.Youare'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Dialog errorDialog = Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12.0)), //this right here
                            child: Container(
                              height: 400.0,
                              width: 600.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                        right: 24,
                                        left: 24,
                                        top: 24,
                                        bottom: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            child: Text(
                                                translate(
                                                    'home.ConnectMetaMask'),
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  MetaMaskPage(),
                                  // Comment this line if running on Mobile Phone ( Android / iOS)
                                  Spacer(
                                    flex: 1,
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                ],
                              ),
                            ),
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => errorDialog);
                        },
                        child: Text(translate('home.network')),
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                ColorConstants.AppBlueColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ))))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
