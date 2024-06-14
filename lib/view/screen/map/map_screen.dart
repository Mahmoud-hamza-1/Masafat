import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final controller = MapController.withUserPosition(
      trackUserLocation: const UserTrackingOption(
    enableTracking: true,
    unFollowUser: false,
  ));

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            OSMFlutter(
              // mapIsLoading:
              //     const Center(child: CircularProgressIndicator.adaptive()),
              onGeoPointClicked: (p0) async {
                print(p0.latitude);
                print(p0.longitude);
              },
              controller: controller,
              osmOption: OSMOption(
                showZoomController: true,
                userTrackingOption: const UserTrackingOption(
                  enableTracking: true,
                  unFollowUser: true,
                ),
                zoomOption: const ZoomOption(
                  initZoom: 15,
                  minZoomLevel: 3,
                  maxZoomLevel: 19,
                  stepZoom: 1.0,
                ),
                userLocationMarker: UserLocationMaker(
                  personMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.location_history_rounded,
                      color: Colors.red,
                      size: 48,
                    ),
                  ),
                  directionArrowMarker: const MarkerIcon(
                    icon: Icon(
                      Icons.double_arrow,
                      size: 48,
                    ),
                  ),
                ),
                staticPoints: [
                  // StaticPositionGeoPoint(
                  //     "id1 ",
                  //     MarkerIcon(
                  //       iconWidget: IconButton(
                  //           onPressed: () {
                  //             print('object');
                  //           },
                  //           icon: const Icon(Icons.mark_as_unread)),
                  //     ),
                  //     [
                  //       GeoPoint(
                  //         latitude: 45,
                  //         longitude: 5,
                  //       ),
                  //       GeoPoint(
                  //         latitude: 50,
                  //         longitude: 15,
                  //       ),
                  //       GeoPoint(
                  //         latitude: 55,
                  //         longitude: 15,
                  //       ),
                  //       GeoPoint(
                  //         latitude: 45,
                  //         longitude: 10,
                  //       ),
                  //     ])
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: (value) async {
                  List<SearchInfo> suggestions = await addressSuggestion(value);
                  for (var element in suggestions) {
                    controller.addMarker(GeoPoint(
                        latitude: element.point!.latitude,
                        longitude: element.point!.longitude));
                    print(element.address);
                  }
                },
                decoration: const InputDecoration(
                    label: Text('address'),
                    filled: true,
                    border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
