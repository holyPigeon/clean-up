import 'package:flutter/material.dart';
import 'package:kyonggi_project/screens/parking_lot_predict.dart';
import 'package:kyonggi_project/screens/time_predict.dart';
import '../oss/oss_page.dart';
import 'main_screen.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const MainScreen(),
    const TimePredict(),
    const ParkingLotPredict(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/logo.png',
            width: 130,
          ),
          centerTitle:  true,
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OssLicensesPage()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '메인',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock),
              label: '시간예측',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_parking),
              label: '조건예측',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
    );
  }
}
