import 'package:api_project/providers/my_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MyMap extends StatelessWidget {
  LatLng gazaLocation = LatLng(31.24, 34.19);
  GoogleMapController controller;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, x) {
      return Scaffold(
        body: GoogleMap(
          onTap: (x){
          },
          markers:provider.markers,
          onMapCreated: (x) {
            this.controller = x;
          },
          initialCameraPosition: CameraPosition(
            target: const LatLng(45.521563, -122.677433),
            zoom: 11.0,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: gazaLocation, zoom: 11)));
            provider.addMarkerToSet(Marker(markerId: MarkerId('gaza'),position: gazaLocation));
          },
        ),
      );
    });
  }
}
