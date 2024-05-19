import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/services/parking_lot_predict.dart';
import '../models/dust_info.dart';
import '../models/weather_info.dart';
import 'nav_pollution_charts.dart';

class InputInfos extends StatefulWidget {
  const InputInfos({
    super.key,
    this.hour,
    this.minute,
    required this.dustInfoResult,
    required this.outSideDataResult,
  });
  final hour;
  final minute;
  final DustInfo dustInfoResult;
  final WeatherInfo outSideDataResult;

  @override
  State<InputInfos> createState() => _InputInfosState();
}

class _InputInfosState extends State<InputInfos> {

  final outSideTemperatureController = TextEditingController();
  final inSideTemperatureController = TextEditingController();
  final outSideHumidityController = TextEditingController();
  final inSideHumidityController = TextEditingController();
  final outSideNoxController = TextEditingController();
  final outSideSoxController = TextEditingController();
  final insideNoxController = TextEditingController();
  final insideSoxController = TextEditingController();
  final dieselCarRatioController = TextEditingController();
  final carCountController = TextEditingController();

  bool _canSubmit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      outSideTemperatureController.text = widget.outSideDataResult.temp.toString();
      outSideHumidityController.text = widget.outSideDataResult.humidity.toString();
      outSideNoxController.text = widget.dustInfoResult.nox.toString();
      outSideSoxController.text = widget.dustInfoResult.sox.toString();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '설정된 시간: ${widget.hour}시 ${widget.minute}분',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inSideTemperatureController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '내부온도',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: outSideTemperatureController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '외부온도',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:  inSideHumidityController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '내부습도',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: outSideHumidityController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '외부습도',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:  insideSoxController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '내부 SOx',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: outSideSoxController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '외부 SOx',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: insideNoxController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '내부 NOx',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: outSideNoxController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '외부 NOx',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: carCountController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '차량대 수',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    controller: dieselCarRatioController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      labelText: '경유차 비율',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {

                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text('취소',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: ()async{
                      log("확인 버튼 눌림");
                      carCount = int.parse(carCountController.text);
                      dieselCarRatio = double.parse(dieselCarRatioController.text);
                      inSideTemperature = double.parse(inSideTemperatureController.text);
                      inSideHumidity = double.parse(inSideHumidityController.text);
                      insideNox = double.parse(insideNoxController.text);
                      insideSox = double.parse(insideSoxController.text);
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: const Text('확인',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
