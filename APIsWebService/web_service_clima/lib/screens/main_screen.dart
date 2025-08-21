import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_service_clima/models/clima.dart';
import 'package:web_service_clima/providers/clima_provider.dart';
import 'package:web_service_clima/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _cidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _climaProvider = Provider.of<ClimaProvider>(context);

    String? _erro;

    return Scaffold(
      appBar: CustomAppBar(title: "Página Inicial"),
      body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
        TextField(
          controller: _cidadeController,
          decoration: const InputDecoration(
          labelText: "Digite uma Cidade",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.location_city),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
          icon: const Icon(Icons.search),
          label: const Text("Buscar Clima"),
          onPressed: () {
            Provider.of<ClimaProvider>(
            context,
            listen: false,
            ).buscarCidade(_cidadeController.text.trim());
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(fontSize: 16),
          ),
          ),
        ),
        const SizedBox(height: 24),
        const Divider(),
        const SizedBox(height: 16),
        Consumer<ClimaProvider>(
          builder: (context, climaProvider, child) {
          if (climaProvider.clima != null) {
            return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                "Cidade: ${climaProvider.clima?.cidade}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                ),
                const SizedBox(height: 8),
                Text(
                "Temperatura: ${climaProvider.clima?.temperatura}°C",
                style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                "Descrição: ${climaProvider.clima?.descricao}",
                style: const TextStyle(fontSize: 16),
                ),
              ],
              ),
            ),
            );
          } else if (climaProvider.erro != null) {
            return Text(
            climaProvider.erro!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            );
          } else {
            return const Text(
            "Procure uma Cidade",
            style: TextStyle(fontSize: 16, color: Colors.grey),
            );
          }
          },
        ),
        ],
      ),
      ),
    );
  }
}
