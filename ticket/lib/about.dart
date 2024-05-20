import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This will remove the back arrow
        title: Center(child: Text('About us')),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'About Tren E-Ticket System',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tren E-Ticket System is your one-stop solution for all train travel needs. With our user-friendly platform, you can easily book tickets, check schedules, and discover exclusive offers for your journey.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Features',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            FeatureItem(
              icon: Icons.book_online,
              title: 'Book Tickets Online',
              description:
                  'Conveniently book train tickets from anywhere, anytime.',
            ),
            FeatureItem(
              icon: Icons.schedule,
              title: 'Check Train Schedules',
              description:
                  'View train schedules and plan your journey in advance.',
            ),
            FeatureItem(
              icon: Icons.local_offer,
              title: 'Discover Offers',
              description:
                  'Explore exclusive offers and discounts for your trips.',
            ),
            SizedBox(height: 30),
            Text(
              'Why Choose Us?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 10),
            AdvantageItem(
              title: 'Convenience',
              description:
                  'Book tickets and plan your journey with ease from your smartphone or computer.',
            ),
            AdvantageItem(
              title: 'Reliability',
              description:
                  'Count on us for accurate schedule information and secure transactions.',
            ),
            AdvantageItem(
              title: 'Affordability',
              description:
                  'Take advantage of our competitive pricing and special offers.',
            ),
            SizedBox(height: 30),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
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
              label: 'info@treneticketsystem.com',
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: Colors.blue),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdvantageItem extends StatelessWidget {
  final String title;
  final String description;

  const AdvantageItem({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 32, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
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
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
