// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kyonggi_project/models/dust_info.dart';
import 'package:kyonggi_project/models/weather_info.dart';
import 'package:kyonggi_project/services/dust_info_service.dart';
import 'package:kyonggi_project/services/weather_info.dart';
import 'package:kyonggi_project/widgets/box.dart';
import 'package:kyonggi_project/widgets/parkingdata.dart';
import 'package:kyonggi_project/widgets/pollution_chart.dart';

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
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [

        ],
      ),
    );
  }
}
