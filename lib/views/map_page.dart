import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapboxMap mapboxMap;
  PointAnnotationManager? _annotationManager;

  @override
  void initState() {
    super.initState();
    _setMapboxToken();
  }

  void _setMapboxToken() {
    final mapboxToken = dotenv.env['MAPBOX_ACCESS_TOKEN'];
    if (mapboxToken == null || mapboxToken.isEmpty) {
      debugPrint(
          "⚠️ Mapbox API Key tidak ditemukan! Pastikan .env sudah benar.");
    } else {
      MapboxOptions.setAccessToken(mapboxToken);
      debugPrint("✅ Mapbox API Key diterapkan.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapbox - Mini Library'),
      ),
      body: MapWidget(
        key: const ValueKey("mapWidget"),
        styleUri: MapboxStyles.MAPBOX_STREETS,
        cameraOptions: CameraOptions(
          center: Point(coordinates: Position(-6.25609, 106.61862)),
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
      iconSize: 2.0, // Pastikan ukurannya visible
    ));

    debugPrint("📍 Marker berhasil ditambahkan.");
  }

  @override
  void dispose() {
    _annotationManager = null; // Pastikan tidak ada referensi yang tertinggal
    super.dispose();
  }
}
