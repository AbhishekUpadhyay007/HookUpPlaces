import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../providers/Places_provider.dart';
import '../widdgets/ImagePicker.dart';
import '../widdgets/location_input.dart';

class AddPlaces extends StatefulWidget {
  static const routeName = './AddPlaces';

  @override
  _AddPlacesState createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {

  var _titleController = TextEditingController();
  File _fileSrc;
  String address;
  double latitude, longitude;

  void _savePlace() {
    if (_titleController.text.isEmpty || _fileSrc == null) {
      return;
    }
    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _fileSrc, address, latitude, longitude);
    Navigator.of(context).pop();
  }

  void onImageSelect(File image) {
    _fileSrc = image;
  }

  void placeLocationInfo(String address, double lat, double lng){
    this.address = address;
    latitude = lat;
    longitude = lng;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new places'),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Add Title'),
                    controller: _titleController,
                  ),
                  ImageInput(onImageSelect),
                  SizedBox(height: 15,),
                  LocationInput(placeLocationInfo),
                ],
              ),
            ),
            RaisedButton.icon(
              onPressed: _savePlace,
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              color: Theme.of(context).accentColor,
              label: Text(
                'Add Place',
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        ),
    );
  }
}
