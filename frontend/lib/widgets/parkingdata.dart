// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kyonggi_project/models/parking_lot_info.dart';
import 'package:kyonggi_project/services/parking_info.dart';

import '../screens/time_predict.dart';

class ParkingDataWidget extends StatefulWidget {
  final int month;
  final int day;
  final int hour;
  final int minute;
  const ParkingDataWidget({
    Key? key,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
  }) : super(key: key);

  @override
  State<ParkingDataWidget> createState() => _ParkingDataWidgetState();
}

class _ParkingDataWidgetState extends State<ParkingDataWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ParkingLotInfo>>(
      future: fetchParkingInfo(month, day, hour, minute),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return DataTable(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            dataTextStyle: const TextStyle(color: Colors.black),
            dataRowMinHeight: 30,
            dataRowMaxHeight: 50,
            columnSpacing: 3,
            columns: <DataColumn>[
              DataColumn(label: Container()),
              const DataColumn(
                  label: Text(
                '기온\n(°C)',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              )),
              const DataColumn(
                  label: Text(
                '습도\n(%)',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              )),
              const DataColumn(
                  label: Text(
                'NOx\n(ppm)',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              )),
              const DataColumn(
                  label: Text(
                'SOx\n(ppm)',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              )),
              const DataColumn(
                  label: Text(
                '차량수\n(대)',
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              )),
            ],
            rows: <DataRow>[
              DataRow(
                cells: <DataCell>[
                  const DataCell(Text(
                    '외부',
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                  )), // 첫 번째 로우의 새로운 컬럼 값
                  DataCell(Center(
                    child: Text(
                      '${data[0].exTemperature}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].exHumidity}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].exNox}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].exSox}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].carCount}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                ],
              ),
              DataRow(
                cells: <DataCell>[
                  const DataCell(Center(
                    child: Text(
                      '내부',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].temperature}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].humidity}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].nox}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  DataCell(Center(
                    child: Text(
                      '${data[0].sox}',
                      style: const TextStyle(color: Colors.black),
                    ),
                  )),
                  const DataCell(Text('')), // 차량 수는 첫 번째 줄에만 표시
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}'); // 오류 처리
        }
        // 데이터 로딩 중 표시할 위젯
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
