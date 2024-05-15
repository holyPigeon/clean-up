import 'package:flutter/material.dart';

import '../widgets/nav_pollution_charts.dart';

class TimePredict extends StatefulWidget {
  const TimePredict({super.key});

  @override
  State<TimePredict> createState() => _TimePredictState();
}

class _TimePredictState extends State<TimePredict> {

  int _month = 3;
  int _day = 7;
  int _hour = 0;
  int _minute = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: NavPollutionCharts(
        month: _month,
        day: _day,
        hour: _hour,
        minute: _minute,
      ),
    );
  }
}
