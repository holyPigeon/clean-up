import 'package:flutter/material.dart';

class InputInfos extends StatefulWidget {
  const InputInfos({super.key});

  @override
  State<InputInfos> createState() => _InputInfosState();
}

class _InputInfosState extends State<InputInfos> {
  final _temperatureController = TextEditingController();
  final _humidityController = TextEditingController();
  final _vehicleCountController = TextEditingController();
  final _noxController = TextEditingController();
  final _soxController = TextEditingController();

  bool _canSubmit = false;

  @override
  Widget build(BuildContext context) {
    void updateCanSubmit() {
      setState(() {
        _canSubmit = _temperatureController.text.isNotEmpty &&
            _humidityController.text.isNotEmpty &&
            _vehicleCountController.text.isNotEmpty &&
            _noxController.text.isNotEmpty &&
            _soxController.text.isNotEmpty;
      });
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _temperatureController,
                  decoration: const InputDecoration(
                    labelText: '온도',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _soxController,
                  decoration: const InputDecoration(
                    labelText: 'SOx',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _humidityController,
                  decoration: const InputDecoration(
                    labelText: '습도',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _soxController,
                  decoration: const InputDecoration(
                    labelText: 'SOx',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _vehicleCountController,
                  decoration: const InputDecoration(
                    labelText: '차량 대수',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _soxController,
                  decoration: const InputDecoration(
                    labelText: 'SOx',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _noxController,
                  decoration: const InputDecoration(
                    labelText: 'NOx',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _soxController,
                  decoration: const InputDecoration(
                    labelText: 'SOx',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _soxController,
                  decoration: const InputDecoration(
                    labelText: 'SOx',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 145,
                child: TextField(
                  controller: _soxController,
                  decoration: const InputDecoration(
                    labelText: 'SOx',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    updateCanSubmit();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            // 입력된 값을 처리합니다.
            onPressed: _canSubmit
                ? () {
                    // 입력된 값을 처리합니다.
                    int temperature =
                        int.tryParse(_temperatureController.text) ?? 0;
                    int humidity = int.tryParse(_humidityController.text) ?? 0;
                    int vehicleCount =
                        int.tryParse(_vehicleCountController.text) ?? 0;
                    double nox = double.tryParse(_noxController.text) ?? 0.0;
                    double sox = double.tryParse(_soxController.text) ?? 0.0;
                    Navigator.pop(context);
                  }
                : null,
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}
