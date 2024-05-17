import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputInfos extends StatefulWidget {
  const InputInfos({super.key});

  @override
  State<InputInfos> createState() => _InputInfosState();
}

class _InputInfosState extends State<InputInfos> {
  final _outSideTemperatureController = TextEditingController();
  final _inSideTemperatureController = TextEditingController();
  final _outSideHumidityController = TextEditingController();
  final _inSideHumidityController = TextEditingController();
  final _outSideNoxController = TextEditingController();
  final _outSideSoxController = TextEditingController();
  final _insideNoxController = TextEditingController();
  final _insideSoxController = TextEditingController();
  final _dieselCarRatioController = TextEditingController();
  final _carCountController = TextEditingController();

  bool _canSubmit = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _inSideTemperatureController,
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
                  controller: _outSideTemperatureController,
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
                  controller:  _inSideHumidityController,
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
                  controller: _outSideHumidityController,
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
                  controller:  _insideSoxController,
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
                  controller: _outSideSoxController,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    labelText: '.외부 SOx',
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
                  controller: _insideNoxController,
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
                  controller: _outSideNoxController,
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
                  controller: _carCountController,
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
                  controller: _dieselCarRatioController,
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
          ElevatedButton(
            // 입력된 값을 처리합니다.
            onPressed: (){
              if(_inSideTemperatureController.text.isNotEmpty &&
                  _outSideTemperatureController.text.isNotEmpty &&
                  _inSideHumidityController.text.isNotEmpty &&
                  _outSideHumidityController.text.isNotEmpty &&
                  _insideSoxController.text.isNotEmpty &&
                  _outSideSoxController.text.isNotEmpty &&
                  _insideNoxController.text.isNotEmpty &&
                  _outSideNoxController.text.isNotEmpty &&
                  _carCountController.text.isNotEmpty &&
                  _dieselCarRatioController.text.isNotEmpty){
                setState(() {
                  _canSubmit = true;
                });
                Navigator.pop(context);
              }else{
                Fluttertoast.showToast(
                    msg: "모든 값을 입력해주세요.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
              // int temperature =
              //     int.tryParse(_temperatureController.text) ?? 0;
              // int humidity = int.tryParse(_humidityController.text) ?? 0;
              // int vehicleCount =
              //     int.tryParse(_vehicleCountController.text) ?? 0;
              // double nox = double.tryParse(_noxController.text) ?? 0.0;
              // double sox = double.tryParse(_soxController.text) ?? 0.0;
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
