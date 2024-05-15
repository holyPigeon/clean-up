import 'package:flutter/material.dart';
import '../widgets/nav_pollution_charts.dart';

class ParkingLotPredict extends StatefulWidget {
  const ParkingLotPredict({super.key});

  @override
  State<ParkingLotPredict> createState() => _ParkingLotPredictState();
}

class _ParkingLotPredictState extends State<ParkingLotPredict> {

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
