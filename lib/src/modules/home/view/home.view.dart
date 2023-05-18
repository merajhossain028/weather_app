import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/src/modules/home/components/weather.item.dart';
import 'package:weather_app/src/theme/themes/light/light.theme.dart';

import '../../../constants/constants.dart';
import '../../../theme/themes/themes.dart';
import '../api/weather.api.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ref.watch(getWeatherDataProvider).when(
              error: (_, __) => const Center(child: Text('Error')),
              loading: () => const Center(child: CircularProgressIndicator()),
              data: (value) {
                debugPrint('$value');
                String? tem, wind, hum, time;

                List hour = [];
                List temp2m = [];
                if (value != null) {
                  tem = json
                      .decode(value)['current_weather']['temperature']
                      .toString();
                  wind = json
                      .decode(value)['current_weather']['windspeed']
                      .toString();
                  hum = json
                      .decode(value)['current_weather']['winddirection']
                      .toString();
                  time =
                      json.decode(value)['current_weather']['time'].toString();
                  hour = json.decode(value)['hourly']['time'];
                  temp2m = json.decode(value)['hourly']['temperature_2m'];
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: _myDecoration(),
                        child: Column(
                          mainAxisAlignment: mainSpaceBetween,
                          children: [
                            const Row(
                              mainAxisAlignment: mainSpaceBetween,
                              children: [
                                Icon(
                                  Icons.menu,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                Text(
                                  'Dhaka',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Image.asset("assets/images/heavycloudy.png",
                                height: 150.0),
                            Row(
                              crossAxisAlignment: crossStart,
                              mainAxisAlignment: mainCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    tem ?? '0',
                                    style: const TextStyle(
                                      fontSize: 80,
                                      fontWeight: FontWeight.bold,
                                      color: white,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'o',
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 50),
                            Text(
                              time ?? '0',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Divider(
                                color: Colors.white70,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  WeatherItem(
                                    value: wind ?? '0',
                                    unit: 'km/h',
                                    imageUrl: 'assets/images/windspeed.png',
                                  ),
                                  WeatherItem(
                                    value: hum ?? '0',
                                    unit: '%',
                                    imageUrl: 'assets/images/humidity.png',
                                  ),
                                  WeatherItem(
                                    value: wind ?? '0',
                                    unit: '%',
                                    imageUrl: 'assets/images/cloud.png',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: mainSpaceBetween,
                          crossAxisAlignment: crossCenter,
                          children: [
                            const Text(
                              'Forecasts',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: lightPrimaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                itemCount: temp2m.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5.0),
                                    child: Row(
                                      mainAxisAlignment: mainSpaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('dd MMM, yyyy hh:mm a')
                                              .format(
                                                  DateTime.parse(hour[index])),
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${temp2m[index].toString()} C",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      ),
    );
  }

  BoxDecoration _myDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: [
          Color(0xff6b9dfc),
          Color(0xff205cf1),
        ],
        stops: [0.0, 1.0],
      ),
      boxShadow: [
        BoxShadow(
          color: lightPrimaryColor.withOpacity(.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
      borderRadius: BorderRadius.circular(20),
    );
  }
}
