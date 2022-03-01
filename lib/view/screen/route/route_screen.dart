import 'dart:async';

import 'package:activa_efectiva_bus/data/model/response/route_model.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';

const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(0.3312104, -78.1172569);
const LatLng DEST_LOCATION = LatLng(0.3209686, -78.1189522);

// ignore: must_be_immutable
class RouteScreen extends StatefulWidget {
  final RouteModel route;
  RouteScreen({this.route});
  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor sourceIcon;

  BitmapDescriptor destinationIcon;
  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();

  final Set<Marker> _markers = {};

  void onMapCreated(GoogleMapController controller) {
    setMapPins();
    setPolylines();
    controller.setMapStyle(UtilsStyles.mapStyles);
    _controller.complete(controller);
  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/marker.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        'assets/images/marker.png');
  }

  void setMapPins() {
    setState(() {
      // source pin
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: SOURCE_LOCATION,
          icon: sourceIcon));
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: destinationIcon));
    });
  }

  setPolylines() async {
    widget.route.coordinates.forEach((element) {
      polylineCoordinates.add(LatLng(element[1], element[0]));
    });

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly"),
          color: ColorResources.COLOR_PRIMARY,
          width: 4,
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(
        zoom: CAMERA_ZOOM,
        bearing: CAMERA_BEARING,
        tilt: CAMERA_TILT,
        target: SOURCE_LOCATION);
    //Provider.of<CheckoutProvider>(context, listen: false).initializeAddressTypeIcon();
    return Scaffold(
        body: Column(children: [
      CustomAppBar(title: widget.route.name, isBackButtonExist: true),
      Expanded(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            GoogleMap(
                myLocationEnabled: true,
                compassEnabled: true,
                tiltGesturesEnabled: false,
                markers: _markers,
                polylines: _polylines,
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                onMapCreated: onMapCreated),
            SafeArea(
                child: Column(
              children: [
                Expanded(child: SizedBox.shrink()),
                Container(
                  height: 90,
                  width: double.infinity,
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  decoration: BoxDecoration(
                      color: ColorResources.ICON_BG,
                      borderRadius: BorderRadius.only(
                          topRight:
                              Radius.circular(Dimensions.PADDING_SIZE_LARGE),
                          topLeft:
                              Radius.circular(Dimensions.PADDING_SIZE_LARGE))),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        primary: ColorResources.getPrimaryButton(context)),
                    icon: Icon(
                      Icons.directions_bus_rounded,
                      color: Colors.white,
                    ),
                    label: Text(getTranslated('START_TRAVEL', context), style: robotoBold.copyWith(
                        color: ColorResources.getPrimaryInversed(context),
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),),
                    onPressed: () async {
                      await Provider.of<RouteProvider>(context, listen: false).saveSelectedRouteID(widget.route.id);
                      Provider.of<RouteProvider>(context, listen: false).setSelectedRoute();
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 2);                    },
                  ),
                ),
              ],
            ))
          ],
        ),
      )
    ]));
  }
}

class UtilsStyles {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
