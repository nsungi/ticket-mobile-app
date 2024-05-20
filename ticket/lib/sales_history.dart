import 'package:flutter/material.dart';

class SalesHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> salesData;

  SalesHistoryPage({required this.salesData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sales History'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sales History',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: salesData.length,
                itemBuilder: (context, index) {
                  final sale = salesData[index];
                  return _buildSalesItem(
                    sale['ticket_type'],
                    sale['date'],
                    sale['amount'],
                    sale['quantity'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesItem(
      String ticketType, DateTime date, int amount, int quantity) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticketType,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            'Date: ${date.day}/${date.month}/${date.year}',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 5),
          Text(
            'Quantity sold: $quantity',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(height: 5),
          Text(
            'Amount: \$$amount',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

// Example usage:
void main() {
  List<Map<String, dynamic>> salesData = [
    {
      'ticket_type': 'First Class Ticket',
      'date': DateTime(2024, 4, 25),
      'amount': 500,
      'quantity': 5,
    },
    {
      'ticket_type': 'Standard Ticket',
      'date': DateTime(2024, 4, 26),
      'amount': 300,
      'quantity': 10,
    },
    {
      'ticket_type': 'Economy Ticket',
      'date': DateTime(2024, 4, 27),
      'amount': 200,
      'quantity': 8,
    },
  ];

  runApp(MaterialApp(
    home: SalesHistoryPage(salesData: salesData),
  ));
}
