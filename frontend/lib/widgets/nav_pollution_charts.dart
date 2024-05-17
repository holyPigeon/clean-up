// ignore_for_file: prefer_final_fields

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/models/predicted_nox.dart';
import 'package:kyonggi_project/models/predicted_sox.dart';
import 'package:kyonggi_project/services/actual_nox.dart';
import 'package:kyonggi_project/services/actual_sox.dart';
import 'package:kyonggi_project/widgets/box.dart';
import 'package:kyonggi_project/widgets/input_infos.dart';
import '../screens/time_predict.dart';

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
      cancelText: '취소',
      confirmText: '확인',
      locale: const Locale('ko', 'KR'),
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '예측 값 지정',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.blueAccent.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text('날짜', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.blueAccent.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Dialog(
                                child: _selectTime(context)
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('시간', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.blueAccent.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const Dialog(
                              child: InputInfos()
                          );
                        },
                      );
                    },
                    child: const Text("상세 조건 입력", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                '예측 결과',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
