import 'package:flutter/foundation.dart';
import '../models/Places.dart';
import 'dart:io';
import '../helpers/DbHelper.dart';

class PlacesProvider extends ChangeNotifier {
  List<Places> items = [];

  List<Places> get places {
    return [...items];
  }

  Places filterPlaceById(String id){

    return items.firstWhere((place) => place.id == id );

  }

  void addPlace(
      String title, File image, String address, double lat, double lng) {
    final place = Places(
      id: DateTime.now().toString(),
      name: title,
      image: image,
      location: PlaceLocation(address: address, latitute: lat, longitude: lng),
    );
    items.add(place);
    notifyListeners();

    DbHelper.insert('user_data', {
      'id': place.id,
      'title': place.name,
      'image': image.path,
      'address': address,
      'latitude': lat,
      'longitude': lng
    });
  }

  Future<void> fetchPlaces() async {
    final dataList = await DbHelper.getData('user_data');
    items = dataList
        .map(
          (item) => Places(
            id: item['id'],
            name: item['title'],
            location: PlaceLocation(
                address: item['address'],
                latitute: item['latitude'],
                longitude: item['longitude']),
            image: File(item['image']),
          ),
        )
        .toList();

    notifyListeners();
  }
}
