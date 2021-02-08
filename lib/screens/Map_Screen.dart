import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapScreen extends StatefulWidget {
  bool isSelecting;
  LatLng _selectedLocation;

  MapScreen(this.isSelecting, this._selectedLocation);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  var _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map Screen'),
          actions: [
            if (widget.isSelecting)
              IconButton(
                  icon: Icon(Icons.save),
                  onPressed: widget._selectedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(widget._selectedLocation);
                          widget._selectedLocation = null;
                        })
          ],
        ),
        body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
              center: widget._selectedLocation != null
                  ? LatLng(widget._selectedLocation.latitude,
                      widget._selectedLocation.longitude)
                  : LatLng(28.6139, 77.2090),
              minZoom: 3,
              zoom: 15,
              onTap: !widget.isSelecting
                  ? null
                  : (latlng) {
                      setState(() {
                        widget._selectedLocation = latlng;
                      });
                    }),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            if (widget._selectedLocation != null)
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 40.0,
                    height: 40.0,
                    point: LatLng(widget._selectedLocation.latitude,
                        widget._selectedLocation.longitude),
                    builder: (ctx) => widget._selectedLocation == null
                        ? null
                        : Container(
                            child: IconButton(
                                icon: Icon(
                                  Icons.location_on,
                                  color: Colors.red[400],
                                  size: 40,
                                ),
                                onPressed: () {
                                  print('marker placed');
                                })),
                  )
                ],
              )
          ],
        ));
  }
}
