// ignore_for_file: prefer_final_fields

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/models/predicted_nox.dart';
import 'package:kyonggi_project/models/predicted_sox.dart';
import 'package:kyonggi_project/screens/main_screen.dart';
import 'package:kyonggi_project/services/actual_nox.dart';
import 'package:kyonggi_project/services/actual_sox.dart';
import 'package:kyonggi_project/widgets/box.dart';
import 'package:kyonggi_project/widgets/input_infos.dart';

class NavPollutionCharts extends StatefulWidget {
  final int month;
  final int day;
  final int hour;
  final int minute;

  const NavPollutionCharts({
    Key? key,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
  }) : super(key: key);

  @override
  State<NavPollutionCharts> createState() => _PollutionChartsState();
}

class _PollutionChartsState extends State<NavPollutionCharts> {
  int _month = 3;
  int _day = 7;
  int _hour = 0;
  int _minute = 0;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _selectTime(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 30,
      onTimerDurationChanged: (value) {
        setState(() {
          //_timeAPIRequest(value.inHours, value.inMinutes % 60);
          hour = value.inHours;
          minute = value.inMinutes % 60;
        });
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      barrierDismissible: false,
      context: context,
      initialDate: DateTime(2024, 3, 7),
      firstDate: DateTime(2024, 3, 7),
      lastDate: DateTime(2024, 4, 30),
    );
    if (pickedDate != null) {
      //_dateAPIRequest(pickedDate.month, pickedDate.day);
      setState(() {
        month = pickedDate.month;
        day = pickedDate.day;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 30,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: const Text('Date'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Box(
                              width: width * 0.8,
                              height: height * 0.2,
                              widget: _selectTime(context),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Time'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Box(
                              width: width * 0.8,
                              height: height * 0.55,
                              widget: const InputInfos(),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("Infos"),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Box(
                width: width,
                height: height / 3,
                widget: FutureBuilder<List<PredictedNox>>(
                  future: fetchNox(month, day, hour, minute),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: LineChart(_noxChart(data)),
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}',
                          style: const TextStyle(color: Colors.black)); // 오류 처리
                    }
                    // 데이터 로딩 중 표시할 위젯
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              const SizedBox(height: 10),
              Box(
                width: width,
                height: height / 3,
                widget: FutureBuilder<List<PredictedSox>>(
                  future: fetchSox(month, day, hour, minute),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(20),
                        child: LineChart(_soxChart(data)),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        '${snapshot.error}',
                        style: const TextStyle(color: Colors.black),
                      ); // 오류 처리
                    }
                    // 데이터 로딩 중 표시할 위젯
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//LineChart(_noxChart(data)),
  List<FlSpot> _soxDataPoints(List<PredictedSox> data) {
    return data
        .map((data) => FlSpot(
              data.minute * 60.toDouble() +
                  data.hour * 60 * 60.toDouble() +
                  data.day *
                      24 *
                      60 *
                      60.toDouble(), // Calculate milliseconds since epoch
              data.predictedSox,
            ))
        .toList();
  }

  List<FlSpot> _noxDataPoints(List<PredictedNox> data) {
    return data
        .map((data) => FlSpot(
              data.minute * 60.toDouble() +
                  data.hour * 60 * 60.toDouble() +
                  data.day *
                      24 *
                      60 *
                      60.toDouble(), // Calculate milliseconds since epoch
              data.predictedNox,
            ))
        .toList();
  }

  LineChartData _soxChart(List<PredictedSox> data) {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: _soxDataPoints(data),
          color: Colors.blue,
        ),
      ],
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Y축 레이블 숨기기
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Y축 레이블 숨기기
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Y축 레이블 숨기기
        ),
      ),
    );
  }

  LineChartData _noxChart(List<PredictedNox> data) {
    return LineChartData(
      lineBarsData: [
        LineChartBarData(
          spots: _noxDataPoints(data),
          color: Colors.red,
        ),
      ],
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Y축 레이블 숨기기
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Y축 레이블 숨기기
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false), // Y축 레이블 숨기기
        ),
      ),
    );
  }
}
