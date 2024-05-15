// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';

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
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text("주차장 외부 정보",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: const Center(
                    child: Text("온도", style: TextStyle(color: Colors.black)),
                  )
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 248, 248, 248),
                  ),
                  child: const Center(
                    child: Text("습도", style: TextStyle(color: Colors.black)),
                  )
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
                child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text("NOx", style: TextStyle(color: Colors.black)),
                    )
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 248, 248, 248),
                    ),
                    child: const Center(
                      child: Text("SOx", style: TextStyle(color: Colors.black)),
                    )
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            width: double.infinity,
            child: Text("주차장 내부 정보",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                Image.asset("assets/banner.png"),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Expanded(
                      child:  Column(
                        children: [
                          Text("온도(°C)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("19",style: TextStyle(color: Colors.black,fontSize: 20))
                        ],
                      ),
                    ),
                    Expanded(
                      child:  Column(
                        children: [
                          Text("습도(%)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("42",style: TextStyle(color: Colors.black,fontSize: 20))
                        ],
                      ),
                    ),
                    Expanded(
                      child:  Column(
                        children: [
                          Text("차량수(대)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("23",style: TextStyle(color: Colors.black,fontSize: 20))
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Expanded(
                      child:  Column(
                        children: [
                          Text("NOx(ppm)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("0.05",style: TextStyle(color: Colors.black,fontSize: 20))
                        ],
                      ),
                    ),
                    Expanded(
                      child:  Column(
                        children: [
                          Text("SOx(ppm)",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15)),
                          SizedBox(
                            height: 10,
                          ),
                          Text("0.003",style: TextStyle(color: Colors.black,fontSize: 20))
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
