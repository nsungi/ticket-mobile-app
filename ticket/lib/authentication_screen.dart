import 'package:flutter/material.dart';
import 'login_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Header color
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo-tren.png', // logo
              height: 100, // Increased logo height
              width: 120, // Increased logo width
            ),
            SizedBox(width: 10), // Increased space between logo and text
            Text(
              'TRAIN  E-TICKET  SYSTEM',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40), // Increased gap between header and images
            Text(
              'Enjoy hassle-free ticket booking!', // Text between header and images
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20), // Reduced gap between text and images
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: [
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _buildImage(
                          'assets/images/tren.jpg', 350), // Increased width
                      _buildImage(
                          'assets/images/tren2.jpg', 370), // Increased width
                      _buildImage(
                          'assets/images/scan.jpg', 380), // Increased width
                      _buildImage(
                          'assets/images/train1.jpg', 380), // Increased width
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios_rounded),
                            SizedBox(width: 10),
                            Container(
                              width: 150,
                              height: 5,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.arrow_forward_ios_rounded),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // Increased gap between images and card text
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              elevation: 5, // Add elevation to the card
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Explore our services and book your tickets with ease.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 20), // Increased gap before the button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(15),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40), // Increased gap after the card
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imagePath, double width) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Increased gap
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
