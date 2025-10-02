import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sa_localizacao_mapa/models/location_point_model.dart';
import 'package:sa_localizacao_mapa/services/map_service.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<LocationPointModel> points = [];
  final _mapService = MapService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OpenStreetView com pontos"),),
      body: ValueListenableBuilder(valueListenable: points, builder: (context, value, child) {
        return Column(
          children: [
            Expanded(child: FlutterMap(
              options: MapOptions(),
              children: 
            

            ))
          ],
        );
      },),
    );
  }
}
