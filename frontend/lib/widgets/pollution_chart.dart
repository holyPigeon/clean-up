import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/models/predicted_nox.dart';
import 'package:kyonggi_project/models/predicted_sox.dart';
import 'package:kyonggi_project/services/actual_nox.dart';
import 'package:kyonggi_project/services/actual_sox.dart';
import '../screens/time_predict.dart';

class PollutionCharts extends StatefulWidget {
  final int month;
  final int day;
  final int hour;
  final int minute;

  const PollutionCharts({
    Key? key,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
  }) : super(key: key);

  @override
  State<PollutionCharts> createState() => _PollutionChartsState();
}

class _PollutionChartsState extends State<PollutionCharts> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width, // Get screen width
          height: MediaQuery.of(context).size.height / 4,
          child: FutureBuilder<List<PredictedNox>>(
            future: fetchNox(month, day, hour, minute),
            builder: (context, snapshot) {
              //print(snapshot);
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LineChart(
                    LineChartData(
                      lineBarsData: [
                        LineChartBarData(
                          spots: _actualNoxDataPoints(data),
                          color: Colors.red,
                        ),
                        LineChartBarData(
                          spots: _PredictedNoxDataPoints(data),
                          color: Colors.orange,
                        ),
                      ],
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                          left: BorderSide(
                            color: Colors.black,
                            width: 3,
                          ),
                          right: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          top: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                      ),
                      gridData: const FlGridData(show: true),
                      titlesData: const FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                          axisNameWidget: Text(
                            '지정한 시간부터 30분 간격으로 예측한 NOx(주황색)값과 실제 NOx(파란색)값',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          axisNameSize: 20,
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
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
        SizedBox(
          width: MediaQuery.of(context).size.width, // Get screen width
          height: MediaQuery.of(context).size.height / 4,
          child: FutureBuilder<List<PredictedSox>>(
            future: fetchSox(month, day, hour, minute),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(20.0),
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
    );
  }

//LineChart(_noxChart(data)),
  List<FlSpot> _actualSoxDataPoints(List<PredictedSox> data) {
    return data
        .map((data) => FlSpot(
              data.minute * 60.toDouble() +
                  data.hour * 60 * 60.toDouble() +
                  data.day *
                      24 *
                      60 *
                      60.toDouble(), // Calculate milliseconds since epoch
              data.actualSox,
            ))
        .toList();
  }

  List<FlSpot> _predictedSoxDataPoints(List<PredictedSox> data) {
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

  List<FlSpot> _actualNoxDataPoints(List<PredictedNox> data) {
    return data
        .map((data) => FlSpot(
              data.minute * 60.toDouble() +
                  data.hour * 60 * 60.toDouble() +
                  data.day *
                      24 *
                      60 *
                      60.toDouble(), // Calculate milliseconds since epoch
              data.actualNox,
            ))
        .toList();
  }

  List<FlSpot> _PredictedNoxDataPoints(List<PredictedNox> data) {
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
          spots: _actualSoxDataPoints(data),
          color: Colors.blue,
        ),
        LineChartBarData(
          spots: _predictedSoxDataPoints(data),
          color: Colors.orange,
        ),
      ],
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 3,
          ),
          left: BorderSide(
            color: Colors.black,
            width: 3,
          ),
          right: BorderSide(
            color: Colors.black,
            width: 1,
          ),
          top: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      gridData: const FlGridData(show: true),
      titlesData: const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
          axisNameWidget: Text(
            '지정한 시간부터 30분 간격으로 예측한 SOx(주황색)값과 실제 SOx(파란색)값',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          axisNameSize: 20,
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