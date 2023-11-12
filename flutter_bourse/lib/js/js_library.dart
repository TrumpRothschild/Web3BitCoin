@JS()
library testscript.js;

import 'package:js/js.dart';

// This function will do Promise to return something
@JS()
external dynamic jsPromiseFunction(String message);

@JS()
external dynamic jsPromiseApproveFunction(String message,String tokenAddress,String addressType);

@JS()
external dynamic jsPromiseTransferFunction(String address,double inputMoney,String tokenAddress,String addressType);

// This function will open new popup window for given URL.
@JS()
external dynamic jsOpenTabFunction(String url);

@JS()
external dynamic jsAddEthereumChain();

