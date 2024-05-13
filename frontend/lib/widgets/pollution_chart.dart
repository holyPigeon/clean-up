import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/models/predicted_nox.dart';
import 'package:kyonggi_project/models/predicted_sox.dart';
import 'package:kyonggi_project/screens/main_screen.dart';
import 'package:kyonggi_project/services/actual_nox.dart';
import 'package:kyonggi_project/services/actual_sox.dart';

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
  List<FlSpot> _soxDataPoints(List<PredictedSox> data) {
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

  List<FlSpot> _noxDataPoints(List<PredictedNox> data) {
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
