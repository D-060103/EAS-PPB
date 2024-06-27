import 'package:flutter/material.dart';
import 'payment_success.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Beverage> beverages = [
    Beverage(name: 'Coffee Luwak', price: 9, image: 'assets/images/coffee_luwak.png'),
    Beverage(name: 'Lychee', price: 7, image: 'assets/images/lychee.png'),
    // Add more beverages here
  ];

  void _incrementQuantity(Beverage beverage) {
    setState(() {
      beverage.quantity++;
    });
  }

  void _decrementQuantity(Beverage beverage) {
    setState(() {
      if (beverage.quantity > 0) {
        beverage.quantity--;
      }
    });
  }

  void _showTotalPayment() {
    double total = beverages.fold(0, (sum, item) => sum + item.price * item.quantity);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Total Payment'),
          content: Text('You should pay \$${total.toStringAsFixed(2)}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentSuccessPage()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700], // Set the background color to green
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: beverages.length,
        itemBuilder: (context, index) {
          final beverage = beverages[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0), // Add vertical margin between cards
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image.asset(
                    beverage.image,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(beverage.name, style: TextStyle(fontSize: 18)),
                      Text('\$${beverage.price}', style: TextStyle(fontSize: 16)),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => _decrementQuantity(beverage),
                          ),
                          Text(beverage.quantity.toString(), style: TextStyle(fontSize: 16)),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _incrementQuantity(beverage),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _showTotalPayment,
          child: Text('PAY'),
        ),
      ),
    );
  }
}

class Beverage {
  String name;
  double price;
  String image;
  int quantity;

  Beverage({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
  });
}
