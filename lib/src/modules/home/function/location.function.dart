import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnable = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnable) {
    return Future.error('Location Service is disabled');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location Permission is denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location Permission is denied forever, we cannot request permission');
  }
  return await Geolocator.getCurrentPosition();
}
