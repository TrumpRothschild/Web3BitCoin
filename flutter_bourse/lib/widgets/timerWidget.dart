import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  TimerWidget({Key? key, required this.seconds}) : super(key: key);
  int seconds;
  @override
  State<TimerWidget> createState() => _TimerWidgetState(this.seconds);
}

class _TimerWidgetState extends State<TimerWidget> {
  late int seconds;
  _TimerWidgetState(int seconds) {
    this.seconds = seconds;
  }
  static var countdownDuration1 = Duration();

  Duration duration1 = Duration();

  Timer? timer1;

  bool countDown1 = true;

  @override
  void initState() {
    countdownDuration1 = Duration(seconds: seconds);
    startTimer1();
    reset1();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 4,
            ),
            Container(
                margin: EdgeInsets.only(top: 2, bottom: 4),
                child: buildTime1()),
          ]),
    );
  }

  void reset1() {
    if (countDown1) {
      setState(() => duration1 = countdownDuration1);
    } else {
      setState(() => duration1 = Duration());
    }
  }

  void startTimer1() {
    timer1 = Timer.periodic(Duration(seconds: 1), (_) => addTime1());
  }

  void addTime1() {
    final addSeconds = 1;
    if (!mounted) return;
    setState(() {
      final seconds = duration1.inSeconds - addSeconds;
      if (seconds < 0) {
        timer1?.cancel();

        Navigator.pop(context);
      } else {
        duration1 = Duration(seconds: seconds);
      }
    });
  }

  Widget buildTime1() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration1.inHours);
    final minutes = twoDigits(duration1.inMinutes.remainder(60));
    final seconds = twoDigits(duration1.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'Hours'),
      SizedBox(
        width: 4,
      ),
      buildTimeCard(time: minutes, header: 'Minutes'),
      SizedBox(
        width: 4,
      ),
      buildTimeCard(time: seconds, header: 'Seconds'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 238, 238),
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 243, 11, 11),
                  fontSize: 24),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(header,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                  fontWeight: FontWeight.w500)),
        ],
      );
}
