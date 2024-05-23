import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This will remove the back arrow
        title: Center(child: Text('Notification')),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNotificationCard(
              context,
              'Ticket Confirmation',
              'Your ticket for the 10:30 AM train to City Center has been confirmed.',
              Icons.check_circle,
              Colors.green,
            ),
            _buildNotificationCard(
              context,
              'Payment Successful',
              'Your payment of \$45.00 has been successfully processed.',
              Icons.payment,
              Colors.blue,
            ),
            _buildNotificationCard(
              context,
              'Train Delay',
              'The 11:00 AM train to Downtown is delayed by 15 minutes.',
              Icons.warning,
              Colors.orange,
            ),
            _buildNotificationCard(
              context,
              'Special Offer',
              'Get 20% off on your next ticket purchase. Use code SAVE20.',
              Icons.local_offer,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(BuildContext context, String title,
      String message, IconData icon, Color iconColor) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.grey),
          onPressed: () {
            // Add delete logic here
          },
        ),
      ),
    );
  }
}
