import 'package:flutter/material.dart';
import 'authentication_screen.dart';
import 'parent.dart';
import 'check_schedule_page.dart';
import 'view_offers_page.dart';
import 'book_ticket_page.dart';
import 'sales_report.dart';
import 'login_screen.dart';
import 'payment.dart';
import 'terms.dart';
import 'about.dart';
import 'notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Define sales data

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
        '/': (context) => AuthenticationScreen(),
        '/bookTicket': (context) => BookTicketPage(),
        '/checkSchedule': (context) => CheckSchedulePage(),
        '/viewOffers': (context) => ViewOffersPage(),
        '/dashboard': (context) => ParentPage(),
        '/termsAndConditions': (context) => TermsConditionsPage(),
        '/about': (context) => AboutPage(),
        '/salesReport': (context) => SalesReportScreen(),
        '/logout': (context) => LoginScreen(),
        '/notification': (context) => NotificationPage(),
        '/payment': (context) => PaymentPage(
              bookingData: {},
            ),
      },
    );
  }
}
