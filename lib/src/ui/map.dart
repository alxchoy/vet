import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import './provider.dart';

class MapScreen extends StatefulWidget {
  final providers;

  MapScreen({this.providers});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(-12.0969508, -77.0273053);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _onAddMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onAddMarkers() {
    for (var provider in widget.providers) {
      var _position = LatLng(double.parse(provider.latitud), double.parse(provider.longitud));
      _markers.add(Marker(
        infoWindow: InfoWindow(
          title: provider.providerName,
          snippet: 'Ver detalle',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProviderScreen(providerId: provider.providerId))
            );
          }
        ),
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId(_position.toString()),
        position: _position
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clínicas disponibles')
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16.0,
        ),
        markers: _markers
      )
    );
  }
}