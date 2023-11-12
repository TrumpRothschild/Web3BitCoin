///  data_utils.dart
///
///  Created by iotjin on 2021/04/01.
///  description:  项目数据请求 管理类

import '/http/apis.dart';
import '/http/http_utils.dart';

typedef Success<T> = Function(T data);
typedef Fail = Function(int code, String msg);

class DataUtils {
  /// 登录
  static void login<T>(
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    HttpUtils.post(APIs.login, parameters, success: success, fail: fail);
  }

  /// 历史订单记录
  static void getPageList<T>(
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    HttpUtils.get(APIs.getHistoryOrderApi, parameters, success: success, fail: fail);
  }
  /// confirm order  -- 确认下单
  static void confirmOrderPost<T>(parameters, {
    Success? success,
    Fail? fail,
  }) {
    HttpUtils.post(APIs.insertCurrencyOrder, parameters, success: success, fail: fail);
  }

  /// 分页加载分组数据
  static void getPageGroupList<T>(
    parameters, {
    Success? success,
    Fail? fail,
  }) {
    HttpUtils.get(APIs.getGroupPage, parameters, success: success, fail: fail);
  }

  ///查询会员的下级人数（三级以内的代理人数）
  static void getGroupUserCount<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.checkTeamActingApi, parameters, success: success, fail: fail);
  }
///参数 代理下级等级
  static void getUserGroupsBenefitByLevel<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.BenefitByLevelApi, parameters, success: success, fail: fail);
  }
///矿池数据 --
  static void getMiningPoolData<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.getPoolInfoApi, parameters, success: success, fail: fail);
  }
///流动性挖矿记录 ---
  static void getPubMiningRecords<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.getPubMiningRecordsApi, parameters, success: success, fail: fail);
  }
///矿池总资金
  static void getTotalPoolEthApi<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.totalPoolEthApi, parameters, success: success, fail: fail);
  }
  ///挖矿时间倒计时
  static void getTimeApiStatus<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.getTimeApiStatus, parameters, success: success, fail: fail);
  }
///获取以太坊汇率
  static void getEtherscanApi<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.rateApi, parameters, success: success, fail: fail);
  }

///获取授权圈余额状态
  static void getApproveAllowanceApi<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.get(APIs.allowanceApi, parameters, success: success, fail: fail);
  }
  ///inviteCodeApi --邀请码
  static void getInviteCodeApi<T>(
      parameters, {
        Success? success,
        Fail? fail,
      }) {
    HttpUtils.post(APIs.inviteCodeApi, parameters, success: success, fail: fail);
  }

}
