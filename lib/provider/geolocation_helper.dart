import 'package:geolocator/geolocator.dart';

class GeolocationHelper{
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;




}
GeolocationHelper geolocationHelper;