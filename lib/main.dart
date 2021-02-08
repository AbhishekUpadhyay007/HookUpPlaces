import 'package:flutter/material.dart';
import './screens/places_list.dart';
import 'package:provider/provider.dart';
import './providers/Places_provider.dart';
import './screens/add_places.dart';
import './screens/PlaceDetailScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PlacesProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesList(),
        routes: {
          AddPlaces.routeName: (ctx) => AddPlaces(),
          PageDetailScreen.routeName: (ctx) => PageDetailScreen()

        },
      ),
    );
  }
}
