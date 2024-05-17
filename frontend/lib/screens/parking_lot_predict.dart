import 'package:flutter/material.dart';
import '../widgets/nav_pollution_charts.dart';

class ParkingLotPredict extends StatefulWidget {
  const ParkingLotPredict({super.key});

  @override
  State<ParkingLotPredict> createState() => _ParkingLotPredictState();
}

class _ParkingLotPredictState extends State<ParkingLotPredict> {

  final int _month = 3;
  final int _day = 7;
  final int _hour = 0;
  final int _minute = 0;

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
