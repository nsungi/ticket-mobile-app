import 'package:flutter/material.dart';

class ViewOffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This will remove the back arrow
        title: Center(child: Text('Available Offers')),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Special Offers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 16),
              _buildOfferCard(
                context: context,
                offerTitle: '25% Off on First Class Tickets',
                description:
                    'Book now and get 25% off on first class tickets for your next trip.',
                icon: Icons.flight,
                color: Colors.green,
              ),
              SizedBox(height: 16),
              _buildOfferCard(
                context: context,
                offerTitle: 'Family Package Discount',
                description:
                    'Special discounts on group bookings for family trips.',
                icon: Icons.family_restroom,
                color: Colors.orange,
              ),
              SizedBox(height: 16),
              _buildOfferCard(
                context: context,
                offerTitle: 'Weekend Getaway Deals',
                description:
                    'Explore exciting weekend getaway deals to popular destinations.',
                icon: Icons.hotel,
                color: Colors.blueAccent,
              ),
              SizedBox(height: 16),
              _buildOfferCard(
                context: context,
                offerTitle: 'Summer Adventure Sale',
                description:
                    'Discover amazing deals for summer adventures in top destinations.',
                icon: Icons.directions_car,
                color: Colors.deepPurple,
              ),
              SizedBox(height: 16),
              _buildOfferCard(
                context: context,
                offerTitle: 'Senior Citizen Discount',
                description:
                    'Exclusive discounts for senior citizens on train tickets.',
                icon: Icons.accessibility,
                color: Colors.red,
              ),
              SizedBox(height: 16),
              _buildOfferCard(
                context: context,
                offerTitle: 'Student Fare Special',
                description: 'Special fares for students on select routes.',
                icon: Icons.school,
                color: Colors.teal,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCard({
    required BuildContext context,
    required String offerTitle,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.blue, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offerTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the booking page route
                      Navigator.pushNamed(context, '/bookTicket');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    child: Text('Book Now'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
