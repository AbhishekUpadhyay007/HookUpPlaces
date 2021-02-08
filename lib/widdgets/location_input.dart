import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/Location_Helper.dart';
import '../screens/Map_Screen.dart';
import 'package:latlong/latlong.dart';
import 'package:geocoder/geocoder.dart';

class LocationInput extends StatefulWidget {

  final Function locationInfo;

  LocationInput(this.locationInfo);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String locationImage;

  Future<void> getCurrentLocation() async {
    LocationData locData = await Location().getLocation();

    final loadedUrl = LocationHelper.generateLocationPreviewImage(
        latitude: locData.latitude, longitude: locData.longitude);
      
    setState(() {
      locationImage = loadedUrl;
    });

    final address = await getAddressByLatLng(locData.latitude, locData.longitude);
    print(address);

    widget.locationInfo(address, locData.latitude, locData.longitude);

  }

  Future<void> selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (ctx) => MapScreen(true, null), fullscreenDialog: true),
    );

    if (selectedLocation == null) {
      return;
    }
    final loadedUrl = LocationHelper.generateLocationPreviewImage(
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude);

    setState(() {
      locationImage = loadedUrl;
    });

    final address = await getAddressByLatLng(selectedLocation.latitude, selectedLocation.longitude);
    print(address);

    widget.locationInfo(address, selectedLocation.latitude, selectedLocation.longitude);

  }

  Future<String> getAddressByLatLng(double lat, double lng) async{
    final coordinates =
        Coordinates(lat, lng);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
  
    return address[0].addressLine;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: locationImage == null
              ? Text(
                  'No location choosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(locationImage),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          FlatButton.icon(
              onPressed: getCurrentLocation,
              icon: Icon(Icons.location_on,
                  color: Theme.of(context).primaryColor),
              label: Text('Choose current loctaion',
                  style: TextStyle(color: Theme.of(context).primaryColor))),
          FlatButton.icon(
              onPressed: selectOnMap,
              icon: Icon(Icons.map_outlined,
                  color: Theme.of(context).primaryColor),
              label: Text('Choose location on Map',
                  style: TextStyle(color: Theme.of(context).primaryColor))),
        ])
      ],
    );
  }
}
