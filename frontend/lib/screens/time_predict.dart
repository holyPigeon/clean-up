import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:kyonggi_project/models/dust_info.dart';
import 'package:kyonggi_project/models/weather_info.dart';
import 'package:kyonggi_project/services/dust_info_service.dart';
import 'package:kyonggi_project/services/weather_info.dart';
import 'package:kyonggi_project/widgets/box.dart';
import 'package:kyonggi_project/widgets/parkingdata.dart';
import 'package:kyonggi_project/widgets/pollution_chart.dart';

class TimePredict extends StatefulWidget {
  const TimePredict({super.key});

  @override
  State<TimePredict> createState() => _TimePredictState();
}

int month = 3;
int day = 7;
int hour = 0;
int minute = 0;

class _TimePredictState extends State<TimePredict> {

  Widget _selectTime(BuildContext context) {
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 30,
      onTimerDurationChanged: (value) {
        setState(() {
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
    int _month = 3;
    int _day = 7;
    int _hour = 0;
    int _minute = 0;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         padding: const EdgeInsets.all(10),
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Column(
            //           children: [
            //             const Text(
            //               '현재 미세먼지',
            //               style: TextStyle(
            //                 color: Colors.black,
            //               ),
            //             ),
            //             FutureBuilder<DustInfo>(
            //               future: fetchDustInfo(),
            //               builder: (context, snapshot) {
            //                 if (snapshot.hasData) {
            //                   final data = snapshot.data!;
            //                   return Padding(
            //                     padding: const EdgeInsets.all(20),
            //                     child: Column(
            //                       children: [
            //                         Row(
            //                           mainAxisAlignment:
            //                           MainAxisAlignment.center,
            //                           children: [
            //                             const Text(
            //                               'NOx',
            //                               style: TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                             const SizedBox(width: 10),
            //                             Text(
            //                               data.nox,
            //                               style: const TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisAlignment:
            //                           MainAxisAlignment.center,
            //                           children: [
            //                             const Text(
            //                               'SOx',
            //                               style: TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                             const SizedBox(width: 10),
            //                             Text(
            //                               data.sox,
            //                               style: const TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   );
            //                 } else if (snapshot.hasError) {
            //                   return Text('${snapshot.error}',
            //                       style: const TextStyle(
            //                           color: Colors.black)); // 오류 처리
            //                 }
            //                 // 데이터 로딩 중 표시할 위젯
            //                 return const Center(
            //                     child: CircularProgressIndicator());
            //               },
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 10,
            //     ),
            //     Expanded(
            //       child: Container(
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         padding: const EdgeInsets.all(10),
            //         child: Column(
            //           children: [
            //             const Text(
            //               '현재 날씨',
            //               style: TextStyle(
            //                 color: Colors.black,
            //               ),
            //             ),
            //             FutureBuilder<WeatherInfo>(
            //               future: fetchWeatherInfo(),
            //               builder: (context, snapshot) {
            //                 if (snapshot.hasData) {
            //                   final data = snapshot.data!;
            //                   return Padding(
            //                     padding: const EdgeInsets.all(20),
            //                     child: Column(
            //                       children: [
            //                         Row(
            //                           mainAxisAlignment:
            //                           MainAxisAlignment.center,
            //                           children: [
            //                             const Text(
            //                               '기온',
            //                               style: TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                             const SizedBox(width: 10),
            //                             Text(
            //                               data.temp,
            //                               style: const TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                           ],
            //                         ),
            //                         Row(
            //                           mainAxisAlignment:
            //                           MainAxisAlignment.center,
            //                           children: [
            //                             const Text(
            //                               '습도',
            //                               style: TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                             const SizedBox(width: 10),
            //                             Text(
            //                               data.humidity,
            //                               style: const TextStyle(
            //                                   color: Colors.black),
            //                             ),
            //                           ],
            //                         ),
            //                       ],
            //                     ),
            //                   );
            //                 } else if (snapshot.hasError) {
            //                   return Text(
            //                     '${snapshot.error}',
            //                     style:
            //                     const TextStyle(color: Colors.black),
            //                   ); // 오류 처리
            //                 }
            //                 // 데이터 로딩 중 표시할 위젯
            //                 return const Center(
            //                     child: CircularProgressIndicator());
            //               },
            //             ),
            //           ],
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.01,
              ),
              child: Row(
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
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '$_month월 $_day일 $_hour시 $_minute분',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Box(
              width: width,
              height: height * 0.17,
              widget: ParkingDataWidget(
                month: _month,
                day: _day,
                hour: _hour,
                minute: _minute,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Box(
              width: width,
              height: height * 0.5,
              widget: PollutionCharts(
                month: _month,
                day: _day,
                hour: _hour,
                minute: _minute,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
