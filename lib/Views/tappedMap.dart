import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TappedMap extends StatefulWidget {
  const TappedMap({Key? key}) : super(key: key);

  @override
  State<TappedMap> createState() => _TappedMapState();
}

class _TappedMapState extends State<TappedMap> {

//------------------------------------------------------------Variable-----------------------------------------------------------------//
  static const CameraPosition initialCamaraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.0857496555962), zoom: 14);
  List<Marker> myMarker = [];

  @override
  Widget build(BuildContext context) {
    //---------------------------------------------------------------------UI-----------------------------------------------------------------//
    return Scaffold(
        appBar: AppBar(title: const Text("TappedMap"),),
        body: GoogleMap(
          mapType: MapType.normal,
          markers: Set.from(myMarker),
          onTap: _handleTap,
          initialCameraPosition: initialCamaraPosition,
        ),);
  }

  ///_handleTap (markers)----------------------------///
  _handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker.add(Marker(
          markerId: MarkerId(tappedPoint.toString(),), position: tappedPoint),);
    });
  }
}
