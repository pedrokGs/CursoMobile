import 'package:exemplo_geolocator/clima_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  ClimaService climaService = ClimaService();
  String mensagem = "";


  Future<Position?> getLocation() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled) throw Exception("Serviço desabilitado");

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        throw Exception("Permissão não concedida");
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  Future<String> getLocationWeather() async {
    final position = await getLocation();
    if(position == null) throw Exception("Posição nula");

    final climaPosition = await climaService.getCityWeatherByPosition(position);
    if(climaPosition == null) throw Exception("Clima nulo");
    
    return "${climaPosition["name"]} -- ${climaPosition["main"]["temp"] - 273.15} -- Sensação de: ${(climaPosition["main"]["feels_like"] - 273.15)}";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo geolocator"),),
      body: Padding(padding: EdgeInsets.all(16.0), child: Center(child: Column(children: [
        SelectableText(mensagem),
        const SizedBox(height: 24,),
        ElevatedButton(onPressed: () async {
          String result = await getLocationWeather();
          setState(() {
            mensagem = result;
          });
        }, child: Text("Pegar localização"))
      ],),),),
    );
  }
}