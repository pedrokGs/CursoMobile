import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BluetoothScreen());
  }
}

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  List<ScanResult> devices = [];
  bool searching = false;

  void _startScan(){
    setState(() {
      devices.clear();
      searching = true;
    });
    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        devices = results;
        searching = false;
      });
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Bluetooth"),),
    
    body: searching ?
      Center(child: CircularProgressIndicator(),) :
      Expanded(child: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index].device;
          return ListTile(
            title: Text(device.advName.isEmpty ? "Sem Nome" : device.advName),
            subtitle: Text(device.remoteId.toString()),
            trailing: Text(device.readRssi().toString()),
            onLongPress: () {
              device.connect(license: License.free);
            },
          );
      },))
    );
  }
}
