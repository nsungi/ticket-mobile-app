import 'package:flutter/material.dart';
import 'authentication_screen.dart';
import 'parent.dart';
import 'check_schedule_page.dart';
import 'view_offers_page.dart';
import 'book_ticket_page.dart';
import 'sales_report.dart';
import 'sales_history.dart';
import 'login_screen.dart';
import 'payment.dart';
import 'terms.dart';
import 'about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Define sales data
    List<Map<String, dynamic>> salesData = [
      {
        'ticket_type': 'First Class Ticket',
        'date': DateTime(2024, 4, 25),
        'amount': 500,
        'quantity': 5,
      },
      {
        'ticket_type': 'Standard Ticket',
        'date': DateTime(2024, 4, 26),
        'amount': 300,
        'quantity': 10,
      },
      {
        'ticket_type': 'Economy Ticket',
        'date': DateTime(2024, 4, 27),
        'amount': 200,
        'quantity': 8,
      },
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: ParentPage(), // Change this to AuthenticationScreen(),ParentPage()
      initialRoute: '/',
      routes: {
        '/': (context) => ParentPage(),
        '/bookTicket': (context) => BookTicketPage(),
        '/checkSchedule': (context) => CheckSchedulePage(),
        '/viewOffers': (context) => ViewOffersPage(),
        '/dashboard': (context) => ParentPage(),
        '/termsAndConditions': (context) => TermsConditionsPage(),
        '/about': (context) => AboutPage(),
        '/salesReport': (context) => SalesReportScreen(),
        '/salesHistory': (context) => SalesHistoryPage(salesData: salesData),
        '/logout': (context) => LoginScreen(),
        '/payment': (context) => PaymentPage(
              bookingData: {},
            ),
      },
    );
  }
}
