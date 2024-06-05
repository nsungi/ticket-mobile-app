import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SuccessPage extends StatelessWidget {
  final bool paymentSuccess;
  final String ticketId;

  SuccessPage({required this.paymentSuccess, required this.ticketId});

  Future<void> _downloadTicket(BuildContext context) async {
    final downloadUrl =
        'http://192.168.1.115:8000/api/main/tickets/$ticketId/download/';

    try {
      final Uri _url = Uri.parse(downloadUrl);
      if (await canLaunch(_url.toString())) {
        await launch(
          _url.toString(),
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'my_header_key': 'my_header_value'},
        );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paymentSuccess ? 'Payment Success' : 'Payment Failed'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: paymentSuccess ? Colors.green : Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              paymentSuccess ? Icons.check_circle : Icons.error,
              size: 100,
              color: paymentSuccess ? Colors.green : Colors.red,
            ),
            SizedBox(height: 20),
            Text(
              paymentSuccess
                  ? 'Payment was successful!'
                  : 'Payment failed. Please try again.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: paymentSuccess ? Colors.green : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            if (paymentSuccess)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _downloadTicket(context),
                    child: Text('Download Ticket'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Instructions: Click the button above to download your ticket.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the previous page
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
