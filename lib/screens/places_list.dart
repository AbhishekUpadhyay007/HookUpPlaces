import 'package:flutter/material.dart';
import './add_places.dart';
import 'package:provider/provider.dart';
import '../providers/Places_provider.dart';
import '../screens/PlaceDetailScreen.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places List'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaces.routeName);
              })
        ],
      ),
      body: FutureBuilder (
        future: Provider.of<PlacesProvider>(context,  listen: false).fetchPlaces(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<PlacesProvider>(
                    child: const Center(
                        child: Text(
                      'Nothing in places',
                    )),
                    builder: (ctx, placeProvider, ch) =>
                        placeProvider.items.length <= 0
                            ? ch
                            : ListView.builder(
                                itemBuilder: (ctx, i) => ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(placeProvider.items[i].image),
                                  ),
                                  title: Text(placeProvider.items[i].name),
                                  subtitle: Text(placeProvider.items[i].location.address),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(PageDetailScreen.routeName, arguments: placeProvider.items[i].id);
                                  },
                                ),
                                itemCount: placeProvider.items.length,
                            
                              ),
                  ),
      ),
    );
  }
}
