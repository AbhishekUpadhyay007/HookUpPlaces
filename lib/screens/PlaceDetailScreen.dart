import 'package:flutter/material.dart';
import '../providers/Places_provider.dart';
import 'package:provider/provider.dart';
import '../screens/Map_Screen.dart';
import 'package:latlong/latlong.dart';

class PageDetailScreen extends StatelessWidget {
  static const routeName = './PageDetailScreen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final filteredPlace =
        Provider.of<PlacesProvider>(context).filterPlaceById(id);

    return Scaffold(
      body: Column(
        children: [
          Image.file(
            filteredPlace.image,
            height: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${filteredPlace.name}",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Address: ${filteredPlace.location.address}',
                    style: TextStyle(
                        fontSize: 18, color: Theme.of(context).primaryColor),
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Lat: ${filteredPlace.location.latitute} \nLong: ${filteredPlace.location.longitude}"),
                  SizedBox(height: 15),
                  RaisedButton.icon(
                    icon: Icon(Icons.location_on_outlined),
                    label: Text('View On Map'),
                    onPressed: () {
                      print(filteredPlace.location.latitute);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (ctx) => MapScreen(
                              false,
                              LatLng(filteredPlace.location.latitute,
                                  filteredPlace.location.longitude)),
                        ),
                      );
                    },
                    color: Theme.of(context).accentColor,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
