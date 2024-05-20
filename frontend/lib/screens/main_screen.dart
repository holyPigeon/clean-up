// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import '../models/dust_info.dart';
import '../models/parking_lot_info.dart';
import '../models/weather_info.dart';
import '../services/dust_info_service.dart';
import '../services/parking_info.dart';
import '../services/weather_info.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text("주차장 외부 측정 정보 (실시간)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
          ),
          const Divider(
            color: Colors.white,
            height: 1,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "마지막 조회 : ${DateTime.now().year}년 ${DateTime.now().month}월 ${DateTime.now().day}일 ${DateTime.now().hour}시 ${DateTime.now().minute}분"
              ,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          '기온(°C)',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      FutureBuilder<WeatherInfo>(
                        future: fetchWeatherInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                data.temp.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                              style:
                              const TextStyle(color: Colors.black),
                            ); // 오류 처리
                          }
                          // 데이터 로딩 중 표시할 위젯
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          '습도(%)',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      FutureBuilder<WeatherInfo>(
                        future: fetchWeatherInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                data.humidity.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                              style:
                              const TextStyle(color: Colors.black),
                            ); // 오류 처리
                          }
                          // 데이터 로딩 중 표시할 위젯
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'NOx(ppm)',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      FutureBuilder<DustInfo>(
                        future: fetchDustInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                data.nox.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                              style:
                              const TextStyle(color: Colors.black),
                            ); // 오류 처리
                          }
                          // 데이터 로딩 중 표시할 위젯
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'SOx(ppm)',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      FutureBuilder<DustInfo>(
                        future: fetchDustInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data!;
                            return Container(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                data.sox,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40
                                ),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                              '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                              style:
                              const TextStyle(color: Colors.black),
                            ); // 오류 처리
                          }
                          // 데이터 로딩 중 표시할 위젯
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5,right: 10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Text("주차장 내부 측정 정보",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
          ),
          const Divider(
            color: Colors.white,
            height: 1,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text(
              "마지막 조회 : 2024년 4월 30일 23시 30분"
              ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/banner.png",fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                FutureBuilder<List<ParkingLotInfo>>(
                  future: fetchParkingInfo(4,30,23,30),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child:  Column(
                                  children: [
                                    const Text("온도(°C)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data[0].temperature.toString(),style: TextStyle(color: Colors.black,fontSize: 20))
                                  ],
                                ),
                              ),
                              Expanded(
                                child:  Column(
                                  children: [
                                    const Text("습도(%)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data[0].humidity.toString(),style: const TextStyle(color: Colors.black,fontSize: 20))
                                  ],
                                ),
                              ),
                              Expanded(
                                child:  Column(
                                  children: [
                                    const Text("차량수(대)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data[0].carCount.toString(),style: const TextStyle(color: Colors.black,fontSize: 20))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child:  Column(
                                  children: [
                                    const Text("NOx(ppm)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data[0].nox.toString(),style: const TextStyle(color: Colors.black,fontSize: 20))
                                  ],
                                ),
                              ),
                              Expanded(
                                child:  Column(
                                  children: [
                                    const Text("SOx(ppm)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(data[0].sox.toString(),style: const TextStyle(color: Colors.black,fontSize: 20))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        '불러오던 도중 에러가 발생하였습니다.\n${snapshot.error}',
                        style:
                        const TextStyle(color: Colors.black),
                      ); // 오류 처리
                    }
                    // 데이터 로딩 중 표시할 위젯
                    return const Center(
                        child: CircularProgressIndicator());
                  },
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
