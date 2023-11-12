
async function getPlatform() {
  return navigator.platform;
}

async function jsPromiseFunction(message) {
    let msg = message;
    let account ;
    let balance;
    let  sA ;
     web3 = new Web3(new Web3.providers.WebsocketProvider("wss://mainnet.infura.io/ws/v3/5a5a6eeee04f4437960bcebbd31752af"));
     if (typeof window.ethereum != 'undefined') {
      const accounts =  await ethereum.request({ method: 'eth_requestAccounts' });
      account = accounts[0];
      if (ethereum.chainId != 1) {
      }
      }
    let promise = new Promise(function(resolve, reject) {
        resolve(String(account));
    });
    let result = await promise;
    return result;
}

async function jsAddEthereumChain(){
console.log("运行到这里");
  const params = [{
     chainId:"0x38",
     chainName:"BSC Smart Chain",
     rpcUrls:[
      "https://bsc-dataseed.binance.org/"
     ],
     nativeCurrency:{
        name:"Binance coin",
        symbol:"BNB",
        decimals:18
     },
     blockExplorerUrls:[
          "https://bscscan.com"
      ]
  }];
   try {
      await window.ethereum.request({
               method: 'wallet_addEthereumChain',
               params: params,
         }).then(function (value) {
                 status = value;
                console.log('Success: '+value)
         }).catch(function (reason) {
                 if (reason.code == 4001) {
                     status = '';
                 } else {
                   console.log(reason);
                     status = '';
         }});
     const web3 = new Web3(window.ethereum);

   } catch (error) {
      console.error("添加BSC网络失败",error);
   }
}


async function jsOpenTabFunction(url) {
    let promise = new Promise(function(resolve, reject) {
        var win = window.open(url,"New Popup Window","width=800,height=800");
        console.log("window",win);

        var timer = setInterval(function() {
                if (win.closed) {
                    clearInterval(timer);
                    alert("'Popup Window' closed!");
                    resolve('Paid');
                }
            }, 500);
        console.log("window",win);
    });
    let result = await promise;
    console.log("result",result);
    return result;
}
