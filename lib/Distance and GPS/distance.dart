import 'dart:async';
import 'dart:math' show atan2, cos, pi, sin, sqrt;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Distance extends StatefulWidget {
  const Distance({Key? key}) : super(key: key);

  @override
  State<Distance> createState() => _DistanceState();
}

class _DistanceState extends State<Distance> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(-22.617252, 17.073715);
  static const LatLng midPoint = LatLng(-22.615575, 17.074855);
  static const LatLng destination = LatLng(-22.614814, 17.075069);

  List<LatLng> polylineCoordinates = [];

  Future<void> initialize() async {
    getPolyPoints();
  }

  void getPolyPoints() {
    polylineCoordinates.add(sourceLocation);
    polylineCoordinates.add(midPoint);
    polylineCoordinates.add(destination);
    setState(() {}); // Trigger redraw after updating polylineCoordinates
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    double distance = calculateDistance();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: CameraPosition(
                target: LatLng(midPoint.latitude - 0.0002, midPoint.longitude),
                zoom: 18.3,
              ),
              zoomControlsEnabled: false,
              compassEnabled: false,
              polylines: {
                Polyline(
                  polylineId: const PolylineId("route"),
                  points: polylineCoordinates,
                  color: Colors.white,
                  width: 6,
                )
              },
              markers: {
                const Marker(
                  markerId: MarkerId("source"),
                  position: sourceLocation,
                ),
                const Marker(
                  markerId: MarkerId("destination"),
                  position: destination,
                ),
              },
              onMapCreated: (GoogleMapController controller) {
  if (!_controller.isCompleted) {
    _controller.complete(controller);
  }
},

            ),
          ),
          SafeArea(
            child: Positioned(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    
                    height: 46,
                    width: 144,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        '${distance.toStringAsFixed(2)}m',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateDistance() {
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      LatLng point1 = polylineCoordinates[i];
      LatLng point2 = polylineCoordinates[i + 1];
      double distance = _distanceBetween(
        point1.latitude,
        point1.longitude,
        point2.latitude,
        point2.longitude,
      );
      totalDistance += distance;
    }
    return totalDistance;
  }

  double _distanceBetween(double lat1, double lon1, double lat2, double lon2) {
    const double radius = 6371; // Earth's radius in kilometers
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radius * c * 1000; // Convert to meters
    return distance;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }
}
