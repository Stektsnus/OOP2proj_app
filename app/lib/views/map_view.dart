import 'package:flutter/material.dart';
import "../widgets/main_widgets.dart" as main_widgets;
import "package:flutter_map/flutter_map.dart";
import "package:location/location.dart";
import "../models/location_model.dart";
import "../models/user_model.dart";
import "../models/location_model.dart";
import "package:http/http.dart";
import "package:latlong2/latlong.dart";

String dataBaseUrl = "http://10.0.2.2:3000/";

class MapView extends StatefulWidget {
  User? user;

  MapView({Key? key, User? user}) : super(key: key) {
    user = user;
  }

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Future? hasAcceptedLocation;
  Location location = Location();

  @override
  initState() {
    super.initState();
    hasAcceptedLocation = askForLocationPermission().then((value) async {
      if (value) {
        hasAcceptedLocation = value;
      }
    });
  }

  Future askForLocationPermission() async {
    return await LocationModel.requestLocation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: hasAcceptedLocation,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            return FutureBuilder<LocationData>(
              future: location.getLocation(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return FlutterMap(
                        options: MapOptions(
                          center: LatLng(snapshot.data!.latitude!.toDouble(), snapshot.data!.longitude!.toDouble()),
                          zoom: 13.0,
                        ),
                        layers: [
                          TileLayerOptions(
                            urlTemplate:
                                "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                            attributionBuilder: (_) {
                              return Text("© OpenStreetMap contributors");
                            },
                          ),
                          MarkerLayerOptions(
                            markers: [
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(snapshot.data!.latitude!.toDouble(), snapshot.data!.longitude!.toDouble()),
                                builder: (ctx) => Container(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    semanticLabel: "You",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    return Text("Default");
                  default:
                    return Text("Default");
              }
            });
          default:
            return Text("Default");
        }
      },
    );
  }
}


// return FlutterMap(
//                         options: MapOptions(
//                           center: LatLng(snapshot.data.latitude, snapshot.data.longitude),
//                           zoom: 13.0,
//                         ),
//                         layers: [
//                           TileLayerOptions(
//                             urlTemplate:
//                                 "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                             subdomains: ['a', 'b', 'c'],
//                             attributionBuilder: (_) {
//                               return Text("© OpenStreetMap contributors");
//                             },
//                           ),
//                           MarkerLayerOptions(
//                             markers: [
//                               Marker(
//                                 width: 80.0,
//                                 height: 80.0,
//                                 point: LatLng(58.4027, 15.6100),
//                                 builder: (ctx) => Container(
//                                   child: Icon(
//                                     Icons.location_on,
//                                     color: Colors.red,
//                                     semanticLabel: "You",
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );