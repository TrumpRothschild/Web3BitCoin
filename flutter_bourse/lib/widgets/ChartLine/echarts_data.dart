const areaStackGradientData = [
  {'day': 'Mon', 'value': 140, 'group': 1},
  {'day': 'Tue', 'value': 232, 'group': 1},
  {'day': 'Wed', 'value': 101, 'group': 1},
  {'day': 'Thu', 'value': 264, 'group': 1},
  {'day': 'Fri', 'value': 90, 'group': 1},
  {'day': 'Sat', 'value': 340, 'group': 1},
  {'day': 'Sun', 'value': 250, 'group': 1},
  {'day': 'Mon', 'value': 120, 'group': 2},
  {'day': 'Tue', 'value': 282, 'group': 2},
  {'day': 'Wed', 'value': 111, 'group': 2},
  {'day': 'Thu', 'value': 234, 'group': 2},
  {'day': 'Fri', 'value': 220, 'group': 2},
  {'day': 'Sat', 'value': 340, 'group': 2},
  {'day': 'Sun', 'value': 310, 'group': 2},
  {'day': 'Mon', 'value': 320, 'group': 3},
  {'day': 'Tue', 'value': 132, 'group': 3},
  {'day': 'Wed', 'value': 201, 'group': 3},
  {'day': 'Thu', 'value': 334, 'group': 3},
  {'day': 'Fri', 'value': 190, 'group': 3},
  {'day': 'Sat', 'value': 130, 'group': 3},
  {'day': 'Sun', 'value': 220, 'group': 3},
  {'day': 'Mon', 'value': 220, 'group': 4},
  {'day': 'Tue', 'value': 402, 'group': 4},
  {'day': 'Wed', 'value': 231, 'group': 4},
  {'day': 'Thu', 'value': 134, 'group': 4},
  {'day': 'Fri', 'value': 190, 'group': 4},
  {'day': 'Sat', 'value': 230, 'group': 4},
  {'day': 'Sun', 'value': 120, 'group': 4},
  {'day': 'Mon', 'value': 220, 'group': 5},
  {'day': 'Tue', 'value': 302, 'group': 5},
  {'day': 'Wed', 'value': 181, 'group': 5},
  {'day': 'Thu', 'value': 234, 'group': 5},
  {'day': 'Fri', 'value': 210, 'group': 5},
  {'day': 'Sat', 'value': 290, 'group': 5},
  {'day': 'Sun', 'value': 150, 'group': 5},
];

const lineMarkerData = [
  {'day': 'Mon', 'value': 10, 'group': 'Highest'},
  {'day': 'Tue', 'value': 11, 'group': 'Highest'},
  {'day': 'Wed', 'value': 13, 'group': 'Highest'},
  {'day': 'Thu', 'value': 11, 'group': 'Highest'},
  {'day': 'Fri', 'value': 12, 'group': 'Highest'},
  {'day': 'Sat', 'value': 12, 'group': 'Highest'},
  {'day': 'Sun', 'value': 9, 'group': 'Highest'},
  {'day': 'Mon', 'value': 1, 'group': 'Lowest'},
  {'day': 'Tue', 'value': -2, 'group': 'Lowest'},
  {'day': 'Wed', 'value': 2, 'group': 'Lowest'},
  {'day': 'Thu', 'value': 5, 'group': 'Lowest'},
  {'day': 'Fri', 'value': 3, 'group': 'Lowest'},
  {'day': 'Sat', 'value': 2, 'group': 'Lowest'},
  {'day': 'Sun', 'value': 0, 'group': 'Lowest'},
];

const lineSectionsData = [
  [
    '00:00',
    '01:15',
    '02:30',
    '03:45',
    '05:00',
    '06:15',
    '07:30',
    '08:45',
    '10:00',
    '11:15',
    '12:30',
    '13:45',
    '15:00',
    '16:15',
    '17:30',
    '18:45',
    '20:00',
    '21:15',
    '22:30',
    '23:45'
  ],
  [
    100,
    280,
    250,
    260,
    270,
    300,
    550,
    500,
    560,
    540,
    680,
    690,
    760,
    800,
    900,
    1050,
    900,
    1010,
    1020,
    1100
  ],
];

const lineIntenetData = [
  [
    '00:00',
    '01:15',
    '02:30',
    '03:45',
    '05:00',
    '06:15',
    '07:30',
    '08:45',
    '10:00',
    '11:15',
    '12:30',
    '13:45',
    '15:00',
    '16:15',
    '17:30',
    '18:45',
    '20:00',
    '21:15',
    '22:30',
    '23:45'
  ],
  [
    10,
    28,
    25,
    26,
    27,
    30,
    80,
    100,
    180,
    290,
    300,
    280,
    270,
    260,
    267,
    280,
    300,
    360,
    420,
    490
  ],
];

const lineMilitaryIndustryData = [
  [
    '00:00',
    '01:15',
    '02:30',
    '03:45',
    '05:00',
    '06:15',
    '07:30',
    '08:45',
    '10:00',
    '11:15',
    '12:30',
    '13:45',
    '15:00',
    '16:15',
    '17:30',
    '18:45',
    '20:00',
    '21:15',
    '22:30',
    '23:45'
  ],
  [
    5,
    28,
    250,
    260,
    270,
    400,
    550,
    600,
    760,
    840,
    980,
    1090,
    1160,
    1180,
    1200,
    1350,
    1400,
    1510,
    1620,
    1700
  ],
];

const lineEnterpriseData = [
  [
    '00:00',
    '01:15',
    '02:30',
    '03:45',
    '05:00',
    '06:15',
    '07:30',
    '08:45',
    '10:00',
    '11:15',
    '12:30',
    '13:45',
    '15:00',
    '16:15',
    '17:30',
    '18:45',
    '20:00',
    '21:15',
    '22:30',
    '23:45'
  ],
  [
    20,
    50,
    150,
    260,
    270,
    300,
    550,
    400,
    300,
    220,
    100,
    50,
    200,
    250.1,
    270.8,
    280.3,
    290.02,
    320.12,
    380.12,
    383.89
  ],
];

const priceVolumeData = [
  {
    "volume": 4309,
    "stockNumber": "056151",
    "min": 1,
    "money": 8409,
    "max": 3,
    "start": 2,
    "end": 7,
    "id": 2562,
    "time": "2022-12-04"
  },
  {
    "volume": 1808,
    "stockNumber": "056151",
    "min": 1,
    "money": 10941,
    "max": 3,
    "start": 2,
    "end": 6,
    "id": 2196,
    "time": "2022-12-03"
  },
  {
    "volume": 3055,
    "stockNumber": "056151",
    "min": 3,
    "money": 12456,
    "max": 5,
    "start": 4,
    "end": 0,
    "id": 1830,
    "time": "2022-12-02"
  },
  {
    "volume": 3855,
    "stockNumber": "056151",
    "min": 8,
    "money": 5286,
    "max": 10,
    "start": 9,
    "end": 0,
    "id": 1099,
    "time": "2022-12-01"
  },
  {
    "volume": 2366,
    "stockNumber": "056151",
    "min": 0,
    "money": 15479,
    "max": 1,
    "start": 0,
    "end": 3,
    "id": 1098,
    "time": "2022-11-30"
  },
  {
    "volume": 3614,
    "stockNumber": "056151",
    "min": 0,
    "money": 5849,
    "max": 1,
    "start": 0,
    "end": 9,
    "id": 1097,
    "time": "2022-11-29"
  },
  {
    "volume": 750,
    "stockNumber": "056151",
    "min": 4,
    "money": 6342,
    "max": 6,
    "start": 5,
    "end": 2,
    "id": 1096,
    "time": "2022-11-28"
  }
];