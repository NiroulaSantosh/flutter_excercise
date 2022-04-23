import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapWidgetSection extends StatefulWidget {
  const MapWidgetSection({
    Key? key,
    required this.latLng,
  }) : super(key: key);
  final LatLng latLng;

  @override
  State<MapWidgetSection> createState() => _MapWidgetSectionState();
}

class _MapWidgetSectionState extends State<MapWidgetSection> {
  late LatLng latLng;
  late MapboxMapController mapController;

  @override
  void initState() {
    super.initState();
    setState(() {
      latLng = widget.latLng;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MapWidgetSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      latLng = widget.latLng;
    });
    mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: dotenv.env['MAP_BOX_ACCESS_TOKEN'],
      initialCameraPosition: const CameraPosition(
        zoom: 15,
        target: LatLng(14.508, 46.048),
      ),
      onUserLocationUpdated: (location) {
        CameraUpdate.newLatLng(latLng);
      },
      onStyleLoadedCallback: () {
        mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
      },
      onMapCreated: (MapboxMapController controller) {
        mapController = controller;
        controller.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );

        controller.addCircle(
          CircleOptions(
            circleRadius: 8.0,
            circleColor: '#006992',
            circleOpacity: 0.8,
            geometry: latLng,
            draggable: true,
          ),
        );
      },
    );
  }
}
