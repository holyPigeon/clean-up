// ignore_for_file: prefer_final_fields
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/models/predicted_sox.dart';
import 'package:kyonggi_project/services/actual_sox.dart';
import 'package:kyonggi_project/widgets/box.dart';
import 'package:kyonggi_project/widgets/input_infos.dart';
import '../models/dust_info.dart';
import '../models/parking_lot_predicted_nox.dart';
import '../models/weather_info.dart';
import '../screens/time_predict.dart';
import '../services/dust_info_service.dart';
import '../services/parking_lot_predict.dart';
import '../services/weather_info.dart';

double? inSideTemperature;
double? inSideHumidity;
double? insideNox;
double? insideSox;
double? dieselCarRatio;
int? carCount;

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

int _hour = 0;
int _minute = 0;

class _PollutionChartsState extends State<NavPollutionCharts> {

  @override
  void dispose() {
    super.dispose();
  }

  late WeatherInfo _outSideDataResult;
  late DustInfo _dustInfoResult;

  Function? func;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      _outSideDataResult = await fetchWeatherInfo();
      _dustInfoResult = await fetchDustInfo();
    });
  }

  Widget _selectTime(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 30,
      onTimerDurationChanged: (value) {
        setState(() {
          //_timeAPIRequest(value.inHours, value.inMinutes % 60);
          _hour = value.inHours;
          _minute = value.inMinutes % 60;
        });
      },
    );
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
                          return AlertDialog(
                            content: InputInfos(hour: _hour,minute: _minute,dustInfoResult: _dustInfoResult,outSideDataResult: _outSideDataResult,),

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
              widget: FutureBuilder<List<PrakingLotPredictedNox>>(
                future: fetchParkingLotPredictNox(
                  _hour,
                  _minute,
                  carCount ?? 0,
                  dieselCarRatio ?? 0.0,
                  inSideTemperature ?? 0.0,
                  inSideHumidity ?? 0.0,
                  insideNox ?? 0.0,
                  insideSox ?? 0.0,
                ),
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

  List<FlSpot> _noxDataPoints(List<PrakingLotPredictedNox> data) {
    return data
        .map((data) => FlSpot(
              data.passedMinute, // Calculate milliseconds since epoch
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

  LineChartData _noxChart(List<PrakingLotPredictedNox> data) {
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
