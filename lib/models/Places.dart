import 'dart:io';
import 'package:flutter/foundation.dart';

class Places {
  final String id;
  final String name;
  final PlaceLocation location;
  final File image;

  Places({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.image,
  });
}

class PlaceLocation {
  final double latitute;
  final double longitude;
  final String address;

  PlaceLocation({
    @required this.latitute,
    @required this.longitude,
    this.address,
  });
}
