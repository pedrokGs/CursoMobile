import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:web_service_clima/models/clima.dart';

class ClimaService {
  final String _apiKey = "7df56ffd37f6ce631ed2473648db1b5e";

  Future<Clima?> fetchClima(String cidade) async{
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey'
    );

    final response = await http.get(url);

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      final clima = Clima.fromJson(data);
      return clima;
    } else{
      log("Error fetching data: ${response.statusCode}");
      throw Exception("ErrorCode:${response.statusCode}");
    }
  }
}