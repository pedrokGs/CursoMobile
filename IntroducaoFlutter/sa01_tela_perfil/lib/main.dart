import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 70),
          child: SizedBox(
            height: 1000,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(180),
                    color: Colors.grey,
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Image.asset("assets/img/image.png", width: 200, height: 200, fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: Colors.yellow),
                          Icon(Icons.star, color: const Color.fromARGB(255, 196, 196, 196)),
                        ],
                      ),
                      Text("Johan Smith", style: TextStyle(fontSize: 50)),
                      Text("California, USA", style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                        ),
                        Column(
                          children: [
                            Text("Balance", style: TextStyle(fontSize: 20)),
                            Text("\$00.00", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                        ),
                        Column(
                          children: [
                            Text("Orders", style: TextStyle(fontSize: 20)),
                            Text("10.00", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                        ),
                        Column(
                          children: [
                            Text("Total Spent", style: TextStyle(fontSize: 20)),
                            Text("\$00.00", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: ListView(
                      padding: const EdgeInsets.all(8),
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.blue),
                          title: Text(
                            "Personal information",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(
                            Icons.shopping_cart,
                            color: Colors.blue,
                          ),
                          title: Text(
                            "Your Orders",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.favorite, color: Colors.blue),
                          title: Text(
                            "Your Favorites",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.money, color: Colors.blue),
                          title: Text(
                            "Payment",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.shop, color: Colors.blue),
                          title: Text(
                            "Recommended Shops",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.near_me, color: Colors.blue),
                          title: Text(
                            "Nearest Shop",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.facebook),
              label: "Facebook",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.snapchat),
              label: "Snapchat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.play_arrow),
              label: "Youtube",
            ),
          ],
        ),
      ),
    );
  }
}
