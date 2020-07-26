import 'package:geolocator/geolocator.dart';

// ignore: missing_return
Future<Position> getLocation() async {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  return await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
}
