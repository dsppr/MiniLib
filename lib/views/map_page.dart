import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapboxMap mapboxMap;
  PointAnnotationManager? _annotationManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox - Mini Library'),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        styleUri: MapboxStyles.MAPBOX_STREETS, // Gunakan gaya Mapbox standar
        cameraOptions: CameraOptions(
          center: Point(
              coordinates:
                  Position(-6.25609, 106.61862)), // Lokasi perpustakaan
          zoom: 15.0,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }

  void _onMapCreated(MapboxMap map) {
    mapboxMap = map;
    _addMarker();
  }

  Future<void> _addMarker() async {
    _annotationManager ??=
        await mapboxMap.annotations.createPointAnnotationManager();

    await _annotationManager?.create(PointAnnotationOptions(
      geometry: Point(coordinates: Position(-6.25609, 106.61862)),
      textField: "The Johannes Oentoro Library",
      textSize: 12.0,
      iconSize: 1.5,
    ));
  }
}
