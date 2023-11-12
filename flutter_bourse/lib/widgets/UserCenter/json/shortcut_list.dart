import 'package:flutter/material.dart';
import 'package:flutter_bourse/widgets/UserCenter/utils/iconly/iconly_bold.dart';
import 'package:flutter_bourse/widgets/UserCenter/views/send_money.dart';

List shortcutList = [
  {
    'color': const Color(0xFF026EF4),
    'icon': IconlyBold.Download,
  },
  {
    'color': const Color(0xFFFB6A4B),
    'icon': IconlyBold.Upload,
    'route': const SendMoney(),
  },
  {
    'color': const Color(0xFF2BB33A),
    'icon': IconlyBold.Wallet,
  },
  {
    'color': const Color(0xFFAF52C1),
    'icon': IconlyBold.Category,
  },
];

List profilesShortcutList = [
  {
    "index":"1",
    'color': const Color(0xFFe2a935),
    'icon': IconlyBold.Chart,
    'title': "交易記錄",
  },
  {
    "index":"2",
    'color': const Color(0xFF2290b8),
    'icon': IconlyBold.Password,
    'title': "挖礦記錄",
  },
  {
    "index":"3",
    'color': const Color(0xFF6bcde8),
    'icon': IconlyBold.Wallet,
    'title': " 充值  ",
  },
  {
    "index":"4",
    'color': const Color(0xFF6b41dc),
    'icon': Icons.logout,
    'title': " 提現 ",
  },
];


