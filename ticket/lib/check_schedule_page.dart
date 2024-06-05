import 'package:flutter/material.dart';

class CheckSchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This will remove the back arrow
        title: Center(child: Text('Check Schedule')),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Available Routes',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildRouteCard(
                    context: context,
                    routeName: 'Route 1',
                    trainNumber: 'Tren 101',
                    dayOfWeek: 'Monday',
                    departureTime: '08:00 AM',
                    arrivalTime: '10:00 AM',
                    from: 'Dar',
                    to: 'Moro',
                  ),
                  SizedBox(height: 16),
                  _buildRouteCard(
                    context: context,
                    routeName: 'Route 2',
                    trainNumber: 'Tren 202',
                    dayOfWeek: 'Tuesday',
                    departureTime: '10:30 AM',
                    arrivalTime: '12:30 PM',
                    from: 'Dar',
                    to: 'Charinze',
                  ),
                  SizedBox(height: 16),
                  _buildRouteCard(
                    context: context,
                    routeName: 'Route 3',
                    trainNumber: 'Tren 303',
                    dayOfWeek: 'Wednesday',
                    departureTime: '01:00 PM',
                    arrivalTime: '03:00 PM',
                    from: 'Moro',
                    to: 'Dar',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteCard({
    required BuildContext context,
    required String routeName,
    required String trainNumber,
    required String dayOfWeek,
    required String departureTime,
    required String arrivalTime,
    required String from,
    required String to,
  }) {
    return Card(
      elevation: 3,
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.indigo, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              routeName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Train: $trainNumber',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Day: $dayOfWeek',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'From: $from',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'To: $to',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Departure: $departureTime',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  'Arrival: $arrivalTime',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the booking page route
                  Navigator.pushNamed(context, '/bookTicket');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Book Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
