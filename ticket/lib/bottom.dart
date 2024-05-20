import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<String> routes;

  BottomBar({
    required this.currentIndex,
    required this.onTap,
    required this.routes,
  });

  @override
  Widget build(BuildContext context) {
    final double labelFontSize =
        MediaQuery.of(context).size.width * 0.035; // Adjust label font size

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.blue, // Color for selected item
      unselectedItemColor: Colors.grey, // Color for unselected items
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded), // Home icon
          label: 'Home',
          backgroundColor: Colors.white, // Background color
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book), // Favorite icon
          label: 'Booking',
          backgroundColor: Colors.white, // Background color
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_rounded), // Search icon
          label: 'Search',
          backgroundColor: Colors.white, // Background color
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded), // Profile icon
          label: 'Profile',
          backgroundColor: Colors.white, // Background color
        ),
      ],
      type: BottomNavigationBarType
          .fixed, // Ensure icons and labels are always shown
      selectedFontSize: labelFontSize, // Adjust selected label font size
      unselectedFontSize: labelFontSize, // Adjust unselected label font size
    );
  }
}
