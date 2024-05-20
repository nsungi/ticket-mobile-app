import 'package:flutter/material.dart';
import 'bottom.dart';

class ParentPage extends StatefulWidget {
  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  int _currentIndex = 0;

  final List<String> _routes = [
    '/home',
    '/bookTicket',
    '/about',
    '/termsAndConditions',
    '/salesReport',
    '/salesHistory',
    '/logout'
  ];

  void _onTap(int index) {
    if (index >= 0 && index < _routes.length) {
      setState(() {
        _currentIndex = index;
        Navigator.pushNamed(context, _routes[index]);
      });
    } else {
      print('Invalid route index: $index');
      // Handle invalid route index here
    }
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItem(Icons.home, 'Dashboard', _routes[0]),
              _buildMenuItem(Icons.book, 'Book Now', _routes[1]),
              _buildMenuItem(Icons.info, 'About', _routes[2]),
              _buildMenuItem(
                  Icons.description, 'Terms & Conditions', _routes[3]),
              _buildMenuItem(Icons.bar_chart, 'Sales Report', _routes[4]),
              _buildMenuItem(Icons.history, 'Sales History', _routes[5]),
              _buildMenuItem(Icons.logout, 'Logout', _routes[6]),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(IconData icon, String label, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tren E-Ticket System'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _showMenu(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Add your notification logic here
            },
          ),
        ],
      ),
      body: _buildMainContent(),
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        routes: _routes,
      ),
    );
  }

  Widget _buildMainContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Welcome to Tren E-Ticket System',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Explore our services:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildServiceCard(
                    'Book Tickets',
                    'Book tickets for your next journey with ease.',
                    Icons.book,
                    Colors.orange,
                    titleColor: Colors.black,
                    descriptionColor: Colors.grey[700],
                    onTap: () {
                      Navigator.pushNamed(context, _routes[1]);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildServiceCard(
                    'Check Schedule',
                    'View train schedules and plan your trip.',
                    Icons.schedule,
                    Colors.green,
                    titleColor: Colors.black,
                    descriptionColor: Colors.grey[700],
                    onTap: () {
                      Navigator.pushNamed(context, '/checkSchedule');
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildServiceCard(
                  'View Offers',
                  'Discover exclusive offers and discounts.',
                  Icons.local_offer,
                  Colors.blue,
                  titleColor: Colors.black,
                  descriptionColor: Colors.grey[700],
                  onTap: () {
                    Navigator.pushNamed(context, '/viewOffers');
                  },
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              'Featured Destinations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildFeaturedDestination(
              'assets/images/destination1.jpg',
              'Mbeya, Dar',
            ),
            _buildFeaturedDestination(
              'assets/images/destination2.jpg',
              'Dar, Mwanza',
            ),
            _buildFeaturedDestination(
              'assets/images/destination3.jpg',
              'Mbeya, Kigoma',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    String title,
    String description,
    IconData icon,
    Color color, {
    required Color? titleColor,
    required Color? descriptionColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: descriptionColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedDestination(String imagePath, String destination) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Center(
          child: Text(
            destination,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
