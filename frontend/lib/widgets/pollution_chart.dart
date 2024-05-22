import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/models/predicted_nox.dart';
import 'package:kyonggi_project/models/predicted_sox.dart';
import 'package:kyonggi_project/services/actual_nox.dart';
import 'package:kyonggi_project/services/actual_sox.dart';
import '../screens/time_predict.dart';
import 'nav_pollution_charts.dart';

int hours = 0;
int minutes = 0;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    hours = widget.hour;
    minutes = widget.minute;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.redAccent.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(" 예측된 NOx", style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15,top: 5),
          alignment: Alignment.centerLeft,
          child: const Text("(단위:ppm)", style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal
          )
          ),
        ),
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
                      // 그래프에 ppm 단위가 나오도록 설정
                      lineTouchData: const LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          showOnTopOfTheChartBoxArea: false,
                          getTooltipItems: getTooltipItems1,
                        ),
                        enabled: true,
                        handleBuiltInTouches: true,
                      ),
                      titlesData: const FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                            getTitlesWidget: getBottomTitlesTimePredict,
                            reservedSize: 30,
                          ),
                          axisNameWidget: Text(
                            '             0(h)                                                                              12(h)                                                                          24(h)',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          axisNameSize: 20,
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                          ),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                    style: const TextStyle(color: Colors.black)); // 오류 처리
              }
              // 데이터 로딩 중 표시할 위젯
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.blueAccent.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(" 예측된 SOx", style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold
          )
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15,top: 5),
          alignment: Alignment.centerLeft,
          child: const Text("(단위:ppm)", style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal
          )
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
                  '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                  style: const TextStyle(color: Colors.black),
                ); // 오류 처리
              }
              // 데이터 로딩 중 표시할 위젯
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15,top: 5),
          alignment: Alignment.centerLeft,
          child: const Text("(단위:ppm)", style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal
          )
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
            data.day * 24 * 60 * 60.toDouble(), // Calculate milliseconds since epoch
              data.actualNox,
            ))
        .toList();
  }

  List<FlSpot> _PredictedNoxDataPoints(List<PredictedNox> data) {
    return data
        .map((data) => FlSpot(
      data.minute * 60.toDouble() +
          data.hour * 60 * 60.toDouble() +
      data.day * 24 * 60 * 60.toDouble(), // Calculate milliseconds since epoch
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
      gridData: const FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: true,
      ),
      lineTouchData: const LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          showOnTopOfTheChartBoxArea: false,
          getTooltipItems: getTooltipItems2,
        ),
        enabled: true,
        handleBuiltInTouches: true,
      ),
      titlesData: const FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            // getTitlesWidget: getBottomTitlesTimePredict2,
          ),
          axisNameWidget: Text(
            '             0(h)                                                                              12(h)                                                                          24(h)',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
          axisNameSize: 20,
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
          ),
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

List<LineTooltipItem> getTooltipItems3(List<LineBarSpot> lineBars) {
  final LineChartBarData lineChartBarData = lineBars[0].bar;
  final int index = lineBars[0].spotIndex;
  return [
    LineTooltipItem(
      '${lineChartBarData.spots[index].y} ppm',
      const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
    ),
  ];
}

List<LineTooltipItem> getTooltipItems4(List<LineBarSpot> lineBars) {
  final LineChartBarData lineChartBarData = lineBars[0].bar;
  final int index = lineBars[0].spotIndex;
  return [
    LineTooltipItem(
      '${lineChartBarData.spots[index].y} ppm',
      const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
    ),
  ];
}

Widget getBottomTitlesTimePredict(double value, TitleMeta meta) {
  Widget text;

  // 시작 값과 끝 값만 넣기
  switch ((value.toInt()) ~/ 180.toInt()) {
    case 0:
      text = const Text("0(h)");
      break;
    case 222:
      text = const Text("12(h)");
      break;
    case 470:
      text = const Text("24(h)");
      break;
    default:
      text = const Text("");
      break;
  }

  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}

Widget getBottomTitlesTimePredict2(double value, TitleMeta meta) {
  Widget text;

  // 시작 값과 끝 값만 넣기
  var day = value ~/ (24 * 60 * 60);
  var hour = (value - (day * 24 * 60 * 60)) ~/ (60 * 60);
  var minute = (value - day * 24 * 60 * 60 - hour * 60 * 60) ~/ 60;

  switch(day) {
    case 0:
      text = const Text("0(h)");
      break;
    case 222:
      text = const Text("12(h)");
      break;
    case 470:
      text = const Text("24(h)");
      break;
    default:
      text = const Text(" ");
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}