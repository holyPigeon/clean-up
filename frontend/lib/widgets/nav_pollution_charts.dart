// ignore_for_file: prefer_final_fields
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kyonggi_project/models/predicted_sox.dart';
import 'package:kyonggi_project/services/actual_sox.dart';
import 'package:kyonggi_project/widgets/box.dart';
import 'package:kyonggi_project/widgets/input_infos.dart';
import '../models/dust_info.dart';
import '../models/parking_lot_predicted_nox.dart';
import '../models/parking_lot_predicted_sox.dart';
import '../models/weather_info.dart';
import '../screens/time_predict.dart';
import '../services/dust_info_service.dart';
import '../services/parking_lot_predict.dart';
import '../services/weather_info.dart';
import 'input_infos_test.dart';

double? inSideTemperature;
double? inSideHumidity;
double? insideNox;
double? insideSox;
double? dieselCarRatio;
int? carCount;
double? outSideTemperature;
double? outSideHumidity;
double? outSideNox;
double? outSideSox;

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

int parkingLotpredictHour = 0;
int parkingLotpredictMinute = 0;

class _PollutionChartsState extends State<NavPollutionCharts> {

  WeatherInfo? outSideDataResult;
  DustInfo? dustInfoResult;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var a = await fetchWeatherInfo();
      var b = await fetchDustInfo();
      setState(() {
        outSideDataResult = a;
        dustInfoResult = b;
      });
    });
    super.initState();
  }

  Widget _selectTime(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 30,
      onTimerDurationChanged: (value) {
        setState(() {
          //_timeAPIRequest(value.inHours, value.inMinutes % 60);
          parkingLotpredictHour = value.inHours;
          parkingLotpredictMinute = value.inMinutes % 60;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
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
            const Text("외부 정보는 자동으로 채워지나 수정 가능 합니다.", style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
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
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blueAccent.shade400,
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
                    child: const Text('시간', style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.blueAccent.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () =>
                        alterDialogSetState(
                            context: context,
                            confirmPressed: () {
                              if (carCountController.text.isEmpty ||
                                  dieselCarRatioController.text.isEmpty ||
                                  inSideTemperatureController.text.isEmpty ||
                                  inSideHumidityController.text.isEmpty ||
                                  insideNoxController.text.isEmpty ||
                                  insideSoxController.text.isEmpty ||
                                  outSideTemperatureController.text.isEmpty ||
                                  outSideHumidityController.text.isEmpty ||
                                  outSideNoxController.text.isEmpty ||
                                  outSideSoxController.text.isEmpty) {
                                // 토스트 메시지
                                Fluttertoast.showToast(
                                    msg: "모든 값을 입력해주세요.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              } else {
                                setState(() {
                                  carCount = int.parse(carCountController.text);
                                  dieselCarRatio = double.parse(
                                      dieselCarRatioController.text);
                                  inSideTemperature = double.parse(
                                      inSideTemperatureController.text);
                                  inSideHumidity = double.parse(
                                      inSideHumidityController.text);
                                  insideNox =
                                      double.parse(insideNoxController.text);
                                  insideSox =
                                      double.parse(insideSoxController.text);
                                  outSideTemperature = double.parse(
                                      outSideTemperatureController.text);
                                  outSideHumidity = double.parse(
                                      outSideHumidityController.text);
                                  outSideNox =
                                      double.parse(outSideNoxController.text);
                                  outSideSox =
                                      double.parse(outSideSoxController.text);
                                  Navigator.pop(context);
                                });
                              }
                            },
                            closePressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            dustInfoResult: dustInfoResult!,
                            outSideDataResult: outSideDataResult!),
                    child: const Text("상세 조건 입력", style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
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
                '설정된 조건',
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
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text("차량 수(대)", style: TextStyle(color: Colors
                            .black, fontWeight: FontWeight.bold)),
                        Text("$carCount", style: const TextStyle(color: Colors
                            .black)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        const Text("경유차 비율(%)", style: TextStyle(color: Colors
                            .black, fontWeight: FontWeight.bold)),
                        Text("$dieselCarRatio",
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const Text("내부", style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text("온도(°C)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text("$inSideTemperature",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              const Text("습도(%)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text("$inSideHumidity",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              const Text("NOx(ppm)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text("$insideNox",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              const Text("SOx(ppm)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text("$insideSox",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    const Text("외부", style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                    const Divider(
                      thickness: 1.5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text("온도(°C)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text(outSideDataResult?.temp ?? "null",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              const Text("습도(%)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text(outSideDataResult?.humidity ?? "null",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              const Text("NOx(ppm)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text(dustInfoResult?.nox ?? "null",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              const Text("SOx(ppm)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                              Text(dustInfoResult?.sox ?? "null",
                                  style: const TextStyle(color: Colors.black)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
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
            const Text("그래프를 손으로 누르면 해당 시간의 값이 나옵니다.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.redAccent.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("예측된 NOx", style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 5,
            ),
            Box(
              width: width,
              height: height / 3,
              widget: FutureBuilder<List<PrakingLotPredictedNox>>(
                future: fetchParkingLotPredictNox(
                  parkingLotpredictHour,
                  parkingLotpredictMinute,
                  carCount ?? 0,
                  dieselCarRatio ?? 0.0,
                  inSideTemperature ?? 0.0,
                  inSideHumidity ?? 0.0,
                  insideNox ?? 0.0,
                  insideSox ?? 0.0,
                  outSideTemperature ?? 0.0,
                  outSideHumidity ?? 0.0,
                  outSideNox ?? 0.0,
                  outSideSox ?? 0.0,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: _noxDataPoints(data),
                              color: Colors.red,
                            ),
                          ],
                          // X는 최대 4칸
                          minX: 0,
                          maxX: 120,
                          extraLinesData: ExtraLinesData(
                              horizontalLines: [HorizontalLine(y: 0),],
                              verticalLines: [VerticalLine(x: 0)]),
                          gridData: const FlGridData(
                            show: true,
                          ),
                          titlesData: const FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              axisNameWidget: Text("지정한 시간부터 30분 간격으로 예측한 NOx값 (X축:분)", style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                )
                              ),
                              axisNameSize: 20,
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: getBottomTitles,
                                interval: 20,
                                reservedSize: 30,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false), // Y축 레이블 숨기기
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false), // Y축 레이블 숨기기
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false), // Y축 레이블 숨기기
                            ),
                          ),
                        ),
                      ),
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
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.blueAccent.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text("예측된 SOx", style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 5,
            ),
            Box(
              width: width,
              height: height / 3,
              widget: FutureBuilder<List<PrakingLotPredictedSox>>(
                future: fetchParkingLotPredictSox(
                  parkingLotpredictHour,
                  parkingLotpredictMinute,
                  carCount ?? 0,
                  dieselCarRatio ?? 0.0,
                  inSideTemperature ?? 0.0,
                  inSideHumidity ?? 0.0,
                  insideNox ?? 0.0,
                  insideSox ?? 0.0,
                  outSideTemperature ?? 0.0,
                  outSideHumidity ?? 0.0,
                  outSideNox ?? 0.0,
                  outSideSox ?? 0.0,
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final data = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: _soxDataPoints(data),
                              color: Colors.blue,
                            ),
                          ],
                          // X는 최대 4칸
                          minX: 0,
                          maxX: 120,
                          extraLinesData: ExtraLinesData(
                              horizontalLines: [HorizontalLine(y: 0),],
                              verticalLines: [VerticalLine(x: 0)]),
                          gridData: const FlGridData(
                            show: true,
                          ),
                          titlesData: const FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              axisNameWidget: Text("지정한 시간부터 30분 간격으로 예측한 SOx값 (X축:분)", style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                              axisNameSize: 20,
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: getBottomTitles,
                                interval: 20,
                                reservedSize: 30,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false), // Y축 레이블 숨기기
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false), // Y축 레이블 숨기기
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: false), // Y축 레이블 숨기기
                            ),
                          ),
                        ),
                      ),
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
  List<FlSpot> _soxDataPoints(List<PrakingLotPredictedSox> data) {
    return data
        .map((data) =>
        FlSpot(
          data.passedMinute, // Calculate milliseconds since epoch
          data.predictedNox,
        ))
        .toList();
  }

  List<FlSpot> _noxDataPoints(List<PrakingLotPredictedNox> data) {
    return data
        .map((data) =>
        FlSpot(
          data.passedMinute, // Calculate milliseconds since epoch
          data.predictedNox,
        ))
        .toList();
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text("0");
      break;
    case 60:
      text = const Text("60");
      break;
    case 120:
      text = const Text("120");
      break;
    default:
      text = const Text(" ");
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}