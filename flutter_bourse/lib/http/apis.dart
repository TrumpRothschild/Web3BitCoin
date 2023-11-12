///  apis.dart
///
///  Created by iotjin on 2020/07/07.
///  description:  api 管理

class APIs {
  /// url 前缀
  static const String apiPrefix = "https://console.dgbank.top/prod-api";
  // static const String apiPrefix = "https://console.coinglb.com/prod-api";
  /// 登录接口
  static const String login = "/mobile/userInfo/login";
  /// 刷新token
  static const String refreshToken = "/refreshToken";
  /// 获取历史明细分页数据 -- Get historical breakdown page data
  static const String getHistoryOrderApi = "/client/currencyorder/findUserOrderList";
  /// 获取分页分组数据
  static const String getGroupPage = "/mock/groupPages";
  /// 获取固定数据
  static const String getSimpleArrDic = "/getSimpleArrDic";
  ///确认下单 -- confirm order
  static const String insertCurrencyOrder = "/client/currencyorder/insertCurrencyOrder";
 /// 存款
  static const String saveDepositApi = "/web/frecharge";
  ///提现
  static const String withdrawDepositApi = "/web/fwithdraw";
  // 存取款信息
  static const String moneyInfoApi = "/index/getWalletAddress";
  /// 查询区块链钱包余额  --- check it out Balance
  static const String walletBalanceApi = "/mobile/userAccount/getUsdtMoney";
  ///查看账户余额 -----check it out account balance
  static const String chainMoneyApi = "";
 ///用户提现汇率百分比 ----- User withdrawal rate percentage
  static const String withdrawRateApi = "/client/api/findConfigByKey";
  ///挖矿
  static const String wakuangApi = "/api/du/startmining";
  ///获取自己的以太坊总产出
  static const String totalEthApi = "/api/du/totalEth";
  ///获取平台总资金池
  static const String totalPoolEthApi = "/api/du/totalPoolEth";
  ///获取授权信息
  static const String approveApi = "/api/du/approve";
  ///交换货币
  static const String usdtExchangeApi = "/api/du/exchangeByEth";
  ///获取平台信息
  static const String duAccountApi = "/api/du/account";
  ///换U记录数据
  static const String listHistoryApi = "/api/du/getEthExchangeRecords";
  ///获取自己挖矿到下一次收益的时间
  static const String getMiningTimeApi = "/api/du/getMiningTime";
  ///时间挖矿状态
  static const String getTimeApiStatus = "/api/du/getMiningStatus";
  //挖矿提现记录
  static const String getWithDrawRecords = "/api/du/getWithDrawRecords";
  //挖矿记录
  static const String getMiningRecords = "/api/du/getMiningRecords";
  ///获取用户获得的回扣纪录
  static const String getUserGroupBenefit = "/api/du/getUserGroupBenefitRecords";
/// 查询会员的下级人数（三级以内的代理人数）
  static const String checkTeamActingApi = "/api/du/getGroupUserCount";
///参数 代理下级等级
  static const String BenefitByLevelApi = "/api/du/getUserGroupsBenefitByLevel";
///挖矿提现-API
  static const String insertWithdrawApi = "/api/du/insertWithDraw";
  ///获取盗U平台余额
  static const String getBalanceApi = "/api/du/getBalance";
  ///获取矿池信息
  static const String getPoolInfoApi = "/api/du/getPoolInfo";
  ///流动性挖矿记录
  static const String getPubMiningRecordsApi = "/api/du/getPubMiningRecords";

  ///获取以太坊汇率
  static const String rateApi = "https://api.etherscan.io/api?module=stats&action=ethprice&apikey=1C2HGYVXKPAP2DHBGJPFUKM18I5BUIZRB6";

  static const String allowanceApi = "/api/du/getAllowance";
  ///邀请码
  static const String inviteCodeApi = "/mobile/userAccount/getInviteCode";
}
