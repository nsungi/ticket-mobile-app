import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> bookingData;

  PaymentPage({required this.bookingData});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String _paymentMethod = 'Cash';
  List<String> _paymentMethodChoices = ['Cash', 'Card'];

  Future<void> _submitPayment() async {
    final ticketId = widget.bookingData['id']?.toString() ?? '';
    final fareAmount = widget.bookingData['fare_amount']?.toString() ?? '';
    final paymentMethod = _paymentMethod;

    if (ticketId.isEmpty || fareAmount.isEmpty) {
      print('Booking data is incomplete.');
      return;
    }

    final url = 'http://192.168.1.116:8000/main/payments/create/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'ticket': ticketId,
        'fare_amount': fareAmount,
        'payment_method': paymentMethod,
      }),
    );

    if (response.statusCode == 201) {
      print('Payment successful.');
      final downloadUrl =
          'http://192.168.1.116:8000/main/tickets/$ticketId/download/';

      try {
        final Uri _url = Uri.parse(downloadUrl);
        if (await canLaunchUrl(_url)) {
          await launchUrl(_url, mode: LaunchMode.externalApplication);
          print('Launching URL: $downloadUrl');
        } else {
          print('Could not launch URL: $downloadUrl');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to launch the download URL.'),
              duration: Duration(seconds: 5),
            ),
          );
        }
      } catch (e) {
        print('Exception while launching URL: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred while launching the URL.'),
            duration: Duration(seconds: 5),
          ),
        );
      }
    } else {
      print('Payment failed. Please try again.');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment failed. Please try again.'),
          duration: Duration(seconds: 5),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final travelDate = widget.bookingData['travel_date'] != null
        ? DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(widget.bookingData['travel_date']))
        : 'Unknown';

    final fareAmount =
        widget.bookingData['fare_amount']?.toString() ?? 'Unknown';

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fare Amount: Tsh $fareAmount',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Travel Date: $travelDate',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _paymentMethod,
                  onChanged: (newValue) {
                    setState(() {
                      _paymentMethod = newValue!;
                    });
                  },
                  items: _paymentMethodChoices.map((method) {
                    return DropdownMenuItem(
                      child: Text(method),
                      value: method,
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Payment Method',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _submitPayment,
                    child: Text(
                      'Pay',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.symmetric(vertical: 15),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
