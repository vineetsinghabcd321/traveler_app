import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceMapPage extends StatefulWidget {
  final Map<String, dynamic> place;

  const PlaceMapPage({Key? key, required this.place}) : super(key: key);

  @override
  State<PlaceMapPage> createState() => _PlaceMapPageState();
}

class _PlaceMapPageState extends State<PlaceMapPage> {
  Position? _currentPosition;
  late final LatLng? _placeLatLng;
  Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
    // Expect place to optionally contain 'lat' and 'lng'. If absent, we
    // fallback to opening Google Maps in external app.
    if (widget.place['lat'] != null && widget.place['lng'] != null) {
      _placeLatLng = LatLng((widget.place['lat'] as num).toDouble(),
          (widget.place['lng'] as num).toDouble());
      _determinePosition();
    } else {
      _placeLatLng = null;
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() => _currentPosition = pos);
  }

  double? _distanceKm() {
    if (_currentPosition == null || _placeLatLng == null) return null;
    final meters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      _placeLatLng!.latitude,
      _placeLatLng!.longitude,
    );
    return meters / 1000.0;
  }

  Uri _mapsSearchUri() {
    final query = Uri.encodeComponent(
        '${widget.place['name'] ?? ''} ${widget.place['city'] ?? ''}');
    return Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
  }

  Future<void> _openMapsExternal(BuildContext context) async {
    final uri = _mapsSearchUri();
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Could not open maps for ${widget.place['name'] ?? ''}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.place['name'] ?? 'Place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_placeLatLng != null) ...[
              // Map on top when coordinates are available
              SizedBox(
                height: 300,
                child: _buildMap(),
              ),
              const SizedBox(height: 12),

              // Open-in-maps button directly below the map
              ElevatedButton.icon(
                onPressed: () => _openMapsExternal(context),
                icon: Icon(Icons.map),
                label: Text('Open in Google Maps'),
              ),
              const SizedBox(height: 12),

              // Place image below the map and button
              if (widget.place['imageUrl'] != null &&
                  widget.place['imageUrl'].toString().isNotEmpty)
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Image.network(widget.place['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          Container(color: Colors.grey[300])),
                ),
              const SizedBox(height: 12),

              // Name, city and description below the image
              Text(widget.place['name'] ?? '',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 6),
              Text(widget.place['city'] ?? '',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Text(widget.place['description'] ?? ''),
              const SizedBox(height: 12),

              if (_currentPosition == null)
                Text('Obtaining your location...')
              else
                Text(
                  'Distance from you: ${_distanceKm()!.toStringAsFixed(2)} km',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
            ] else ...[
              // No coordinates: show image and info then offer external map
              if (widget.place['imageUrl'] != null &&
                  widget.place['imageUrl'].toString().isNotEmpty)
                SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Image.network(widget.place['imageUrl'],
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          Container(color: Colors.grey[300])),
                ),
              const SizedBox(height: 12),
              Text(widget.place['name'] ?? '',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 6),
              Text(widget.place['city'] ?? '',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Text(widget.place['description'] ?? ''),
              const SizedBox(height: 12),
              const SizedBox(height: 20),
              Text(
                'No coordinates available for this place. Open externally to view location.',
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => _openMapsExternal(context),
                icon: Icon(Icons.map),
                label: Text('Open in Google Maps'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMap() {
    final initialCamera = CameraPosition(
      target: _placeLatLng!,
      zoom: 12,
    );

    final markers = <Marker>{
      Marker(
        markerId: MarkerId('place'),
        position: _placeLatLng!,
        infoWindow: InfoWindow(title: widget.place['name']),
      ),
    };

    if (_currentPosition != null) {
      final userLatLng = LatLng(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      markers.add(Marker(
        markerId: MarkerId('you'),
        position: userLatLng,
        infoWindow: InfoWindow(title: 'You'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    }

    return GoogleMap(
      initialCameraPosition: initialCamera,
      markers: markers,
      myLocationEnabled: _currentPosition != null,
      onMapCreated: (GoogleMapController controller) {
        if (!_mapController.isCompleted) _mapController.complete(controller);
      },
    );
  }
}
