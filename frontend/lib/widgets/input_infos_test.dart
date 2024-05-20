import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kyonggi_project/models/dust_info.dart';
import 'package:kyonggi_project/models/weather_info.dart';
import 'basic_button.dart';
import 'input_infos.dart';
import 'nav_pollution_charts.dart';

alterDialogSetState({
  required BuildContext context,
  required Function() closePressed,
  required Function() confirmPressed,
  required DustInfo? dustInfoResult,
  required WeatherInfo? outSideDataResult,
}) {
  return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialog) {
            return AlertDialog(
              actionsPadding: const EdgeInsets.only(bottom: 5),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: InputInfos(hour: parkingLotpredictHour,minute: parkingLotpredictMinute,dustInfoResult: dustInfoResult,outSideDataResult: outSideDataResult,),
              ),
              actions: [
                const Divider(thickness: 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    basicButton(buttonText: '닫기', onPressed: closePressed),
                    basicButton(buttonText: '확인', onPressed: confirmPressed)
                  ],
                )
              ],
            );
          }
        )
  );
}