import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('Terms & Conditions')),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to our E-Ticketing System! We are excited to have you on board. Before you start using our services, please take a moment to read through our Terms and Conditions carefully.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 30),
            Text(
              '1. General Terms',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'By accessing or using our E-Ticketing System, you agree to comply with these Terms and Conditions. If you do not agree with any part of these terms, please do not use our services.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Text(
              '2. Payment and Refunds',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'All payments made through our E-Ticketing System are secure and encrypted. We accept various payment methods for your convenience. Refunds are subject to our refund policy.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Text(
              '3. User Responsibilities',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'As a user of our E-Ticketing System, you are responsible for maintaining the confidentiality of your account and password. You are also responsible for all activities that occur under your account.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Text(
              '4. Limitation of Liability',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Our E-Ticketing System is provided on an "as is" and "as available" basis. We do not guarantee that our services will be uninterrupted, timely, secure, or error-free. In no event shall we be liable for any indirect, incidental, special, or consequential damages arising out of or in any way connected with the use of our services.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            ContactItem(
              icon: Icons.phone,
              label: '+1 (123) 456-7890',
            ),
            ContactItem(
              icon: Icons.email,
              label: 'info@eticketsystem.com',
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ContactItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
