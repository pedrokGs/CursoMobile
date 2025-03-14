import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Exemplo Widgets Exibição')),
        body: Center(
          child: Column(
            children: [
              Text(
                'Um Texto Qualquer',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              Image.network(
                'https://th.bing.com/th/id/OIP.vaOkSHzoA8vX5H9hcaxFYAHaHa?rs=1&pid=ImgDetMain',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),

              Image.asset(
                'assets/img/einstein.png',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),

              Icon(Icons.star, color: Colors.yellow, size: 100),
            ],
          ),
        ),
      ),
    );
  }
}
