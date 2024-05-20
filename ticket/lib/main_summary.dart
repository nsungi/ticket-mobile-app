import 'package:flutter/material.dart';
import 'bottom.dart'; // Import your BottomBar widget
import 'home_screen.dart';
import 'search_screen.dart';
import 'booking_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pushNamed(context, _routes[index]);
  }

  final List<String> _routes = [
    '/home',
    '/search',
    '/booking',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: _routes[_currentIndex],
      routes: {
        _routes[0]: (context) => HomeScreen(),
        _routes[1]: (context) => SearchScreen(),
        _routes[2]: (context) => BookingScreen(),
        _routes[3]: (context) => ProfileScreen(),
      },
      home: Scaffold(
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          routes: _routes,
        ),
      ),
    );
  }
}
