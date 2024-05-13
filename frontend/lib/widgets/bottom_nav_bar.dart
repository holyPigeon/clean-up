// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/widgets/box.dart';
import 'package:kyonggi_project/widgets/input_infos.dart';
import 'package:kyonggi_project/widgets/nav_pollution_charts.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int month = 3;
  int day = 7;
  int hour = 0;
  int minute = 0;
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

  double bottomNavbarHeight = 50;
  bool isActivated = true;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int _month = 3;
    int _day = 7;
    int _hour = 0;
    int _minute = 0;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200), // 애니메이션의 길이 설정
      height: bottomNavbarHeight, // 애니메이션의 높이 설정
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              setState(
                () {
                  bottomNavbarHeight =
                      bottomNavbarHeight == 50 ? height * 0.85 : 50;
                  isActivated = !isActivated;
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(35),
              ),
              height: 8,
              width: 100,
            ),
          ),
          isActivated
              ? Container()
              : Padding(
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
                      SizedBox(height: height * 0.01),
                      SizedBox(height: height * 0.01),
                      Box(
                        widget: NavPollutionCharts(
                          month: _month,
                          day: _day,
                          hour: _hour,
                          minute: _minute,
                        ),
                        height: height * 0.6,
                        width: width,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
