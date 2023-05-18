import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../function/location.function.dart';

Future<String?> getWeatherData(double lat, lng) async {
  final newLat = lat.toStringAsFixed(2);
  final newLng = lng.toStringAsFixed(2);
  try {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.open-meteo.com/v1/forecast?latitude=$newLat&longitude=$newLng&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      debugPrint(body);
      return body;
    } else {
      debugPrint(response.reasonPhrase);
      EasyLoading.showError(response.reasonPhrase!);
      return null;
    }
  } on SocketException catch (e) {
    EasyLoading.showError('No Internet Connection. $e');
    return Future.error('No Internet Connection. $e');
  } catch (e) {
    debugPrint(e.toString());
    EasyLoading.showError(e.toString());
    return Future.error(e.toString());
  }
}

final getWeatherDataProvider = FutureProvider((_) async {
  final pos = await getCurrentLocation();
  return await getWeatherData(pos.latitude, pos.longitude);
});
