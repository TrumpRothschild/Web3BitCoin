import 'package:flutter_bourse/utils/utils.dart';

class Category {
  Category({
    this.title = '',
    this.imagePath = '',
    this.lessonCount = 0,
    this.money = 0,
    this.rating = 0.0,
    this.type = 0,
    this.fundType = 0,
    this.price = 0,
    this.contentBank = '',
    this.feeMoney = '',
    this.dingqiMoney = '',
    this.support = "",
    this.hardware = "",
    this.hashRate = "",
    this.power = "",
    this.expectedEarnings = "",
    this.cost = "",
    this.expectedProfit = "",
    this.profitability = ""
  });

  String title;
  int lessonCount;
  int money;
  double rating;
  String imagePath;
  int type;
  int fundType;
  double price;
  String contentBank;
  String feeMoney;
  String dingqiMoney;
  String support;

  String hardware;
  String hashRate;
  String power;
  String expectedEarnings;
  String cost;
  String expectedProfit;
  String profitability;

  static List<Category> categoryList = <Category>[
    Category(
      imagePath: 'assets/images/ustd-circle.png',
      title: '去中心化儲蓄-普通',
      lessonCount: 24,
      money: 25,
      rating: 1.55,
      type: 0,
        contentBank: translate('home.DepositAmount'),
        feeMoney:'46.5%',
        dingqiMoney:'558%'
    ),
    Category(
      imagePath: 'assets/images/ustd-circle.png',
      title: '去中心化儲蓄-铂金',
      lessonCount: 22,
      money: 18,
      rating: 2.58,
      type: 1,
        contentBank: translate('home.DepositAmount'),
        feeMoney:'77.4%',
        dingqiMoney:'928.8%'
    ),
    Category(
      imagePath: 'assets/images/usdt.png',
      title: '去中心化儲蓄-钻石',
      lessonCount: 24,
      money: 25,
      rating: 4.75,
      type: 2,
        contentBank: translate('home.DepositAmount'),
        feeMoney:'142.5%',
        dingqiMoney:'1710%'
    ),

  ];

  static List<Category> popularCourseList = <Category>[
    Category(
      imagePath: 'assets/design_course/interFace3.png',
      title: 'Series EE Savings Bonds',
      rating: 2.10,
        feeMoney:'For savings bonds issued November 1, 2022 to April 30, 2023.'
    ),
    Category(
      imagePath: 'assets/design_course/interFace4.png',
        title: 'Series I Savings Bonds',
        rating: 6.89,
        feeMoney:'For savings bonds issued November 1, 2022 to April 30, 2023.'
    ),
    Category(
      imagePath: 'assets/design_course/interFace3.png',
        title: '30-Year Bonds',
        rating: 4.0,
        feeMoney:'For savings bonds issued November 1, 2022 to April 30, 2023.'
    ),
    Category(
      imagePath: 'assets/design_course/interFace3.png',
        title: '10-Year Notes',
        rating: 4.125,
        feeMoney:'For savings bonds issued November 1, 2022 to April 30, 2023.'
    ),
    Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: '10-Year Notes',
        rating: 4.125,
        feeMoney:'For savings bonds issued November 1, 2022 to April 30, 2023.'
    ),

  ];

  static List<Category> recommendList = <Category>[
    Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: '新手高息',
        lessonCount: 12,
        money: 25,
        rating: 3000.8,
        fundType: 1,
        price: 55.8,
        feeMoney:'100%'
    ),
    Category(
        imagePath: 'assets/design_course/interFace4.png',
        title: '余币宝',
        lessonCount: 28,
        money: 208,
        rating: 1000.9,
        fundType: 2,
        price: 105.8,
        feeMoney:'80%'
    ),
    Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: '定期赚币',
        lessonCount: 12,
        money: 25,
        rating: 2000.8,
        fundType: 3,
        price: 1000.8,
        feeMoney:'90%'
    ),
    Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: 'Sushiswap USDT - ETH',
        lessonCount: 12,
        money: 25,
        rating: 1000.8,
        fundType: 4,
        price: 355.8,
        feeMoney:'46%'
    ),
    Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: 'Compound',
        lessonCount: 12,
        money: 25,
        rating: 1000.8,
        fundType: 4,
        price: 355.8,
        feeMoney:'46%'
    ),
    Category(
        imagePath: 'assets/design_course/interFace3.png',
        title: '双币赢',
        lessonCount: 12,
        money: 25,
        rating: 1000.8,
        fundType: 4,
        price: 355.8,
        feeMoney:'46%'
    ),

  ];

  static List<Category> miningList = <Category>[
    Category(
        imagePath: 'assets/images/bitcoin.png',
        title: 'BTC',
        lessonCount: 24,
        money: 25,
        rating: 100,
        type: 0,
        contentBank: '存款数额 < 20000 USDT',
        feeMoney:'46.5%',
        dingqiMoney:'558%'
    ),
    Category(
        imagePath: 'assets/images/dogecoin.png',
        title: 'Doge',
        lessonCount: 22,
        money: 18,
        rating: 110,
        type: 1,
        contentBank: '存款数额 >= 20000 USDT',
        feeMoney:'77.4%',
        dingqiMoney:'928.8%'
    ),
    Category(
        imagePath: 'assets/images/eth.png',
        title: 'ETH',
        lessonCount: 24,
        money: 25,
        rating: 80,
        type: 2,
        contentBank: '存款数额 >= 50000 USDT',
        feeMoney:'142.5%',
        dingqiMoney:'1710%'
    ),
    Category(
        imagePath: 'assets/images/ustd-circle.png',
        title: 'USDT',
        lessonCount: 24,
        money: 25,
        rating: 120,
        type: 2,
        contentBank: '存款数额 >= 50000 USDT',
        feeMoney:'142.5%',
        dingqiMoney:'1710%'
    ),
    Category(
        imagePath: 'assets/images/Ltccoin.png',
        title: 'LTC',
        lessonCount: 24,
        money: 25,
        rating: 150,
        type: 2,
        contentBank: '存款数额 >= 50000 USDT',
        feeMoney:'142.5%',
        dingqiMoney:'1710%'
    ),

  ];
  static List<Category> miningMachineList = <Category>[
    Category(
        imagePath: 'assets/images/bitcoin.png',
        title: '矿机1号',
        lessonCount: 24,
        money: 25,
        rating: 50,
        type: 0,
        contentBank: '存款数额 < 20000 USDT',
        feeMoney:'46.5%',
        dingqiMoney:'558%',
      support: '支持BTC/BCH挖矿'
    ),
    Category(
        imagePath: 'assets/images/dogecoin.png',
        title: '矿机2号',
        lessonCount: 22,
        money: 18,
        rating: 200,
        type: 1,
        contentBank: '存款数额 >= 20000 USDT',
        feeMoney:'77.4%',
        dingqiMoney:'928.8%',
        support: '支持Doge挖矿'
    ),
    Category(
        imagePath: 'assets/images/eth.png',
        title: '矿机3号',
        lessonCount: 24,
        money: 25,
        rating: 64,
        type: 2,
        contentBank: '存款数额 >= 50000 USDT',
        feeMoney:'142.5%',
        dingqiMoney:'1710%',
        support: '支持ETH挖矿'
    ),

  ];

  static List<Category> miningCoinList = <Category>[
    Category(

      hardware: 'Antminer S19 XP Hyd',
      hashRate: "255 TH/s",
      power: '5304 W',
      expectedEarnings: '18.09 USD',
      cost: '-12.73 USD',
      expectedProfit: '6.39 USD',
      profitability:'50%',
    ),
    Category(

        hardware: 'Antminer L7',
        hashRate: "9500 MH/s",
        power: '3425 W',
        expectedEarnings: '24.61 USD',
        cost: '-8.22 USD',
        expectedProfit: '16.39 USD',
        profitability:'200%',

    ),
    Category(

      hardware: 'Jasminer X4 Server (2500 MH/s)',
      hashRate: "2,500 MH/s",
      power: '1200 W',
      expectedEarnings: '8.14 USD',
      cost: '-2.88 USD',
      expectedProfit: '5.26 USD',
      profitability:'64%',
    ),
    Category(

      hardware: 'Nvidia RTX 3070',
      hashRate: "470,578,207 MH/s",
      power: '72 W',
      expectedEarnings: '265,703.86 USD',
      cost: '-0.17 USD',
      expectedProfit: '265,703.69 USD',
      profitability:'265,70300%',
    ),

    Category(
      hardware: 'Antminer L7',
      hashRate: "9500 MH/s",
      power: '3425 W',
      expectedEarnings: '8.79 USD',
      cost: '-8.22 USD',
      expectedProfit: '0.57 USD',
      profitability:'6%',
    ),
    Category(
      hardware: 'iBeLink BM-K1 Max Blake2S Miner',
      hashRate: "32.0 TH/s",
      power: '3200 W',
      expectedEarnings: '13.15 USD',
      cost: '-7.68 USD',
      expectedProfit: '5.47 USD',
      profitability:'41.5%',
    ),

  ];
}
