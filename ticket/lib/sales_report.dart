import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalesReportScreen extends StatefulWidget {
  @override
  _SalesReportScreenState createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  String _selectedTimePeriod = 'daily';
  List<dynamic> _salesData = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchSalesData();
  }

  Future<void> _fetchSalesData() async {
    final String apiUrl =
        'http://192.168.1.115:8000/api/main/sales-reports/?time_period=$_selectedTimePeriod';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          _salesData = jsonDecode(response.body);
          _errorMessage = '';
        });
      } else {
        setState(() {
          _salesData = [];
          _errorMessage = 'Failed to fetch sales data. Please try again.';
        });
        _showErrorDialog(_errorMessage);
      }
    } catch (e) {
      setState(() {
        _salesData = [];
        _errorMessage = 'An error occurred. Please try again.';
      });
      _showErrorDialog(_errorMessage);
    }
  }

  void _onTimePeriodChanged(String? value) {
    if (value != null) {
      setState(() {
        _selectedTimePeriod = value;
        _fetchSalesData(); // Fetch new data when the time period changes
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales Report'),
        centerTitle: true, // Center the title
        automaticallyImplyLeading: false, // Remove the back arrow
        backgroundColor: Colors.blue.withOpacity(0.9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            _buildTimePeriodSelector(),
            const SizedBox(height: 16.0),
            Expanded(
              child: _salesData.isEmpty
                  ? Center(
                      child: Text(
                        _errorMessage.isNotEmpty
                            ? _errorMessage
                            : 'No records found for $_selectedTimePeriod.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : SingleChildScrollView(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('SN')),
                            DataColumn(label: Text('Class')),
                            DataColumn(label: Text('Route')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Total Sales')),
                          ],
                          rows: _salesData.asMap().entries.map((entry) {
                            final int serialNumber = entry.key + 1;
                            final item = entry.value;
                            return DataRow(cells: [
                              DataCell(Text('$serialNumber')),
                              DataCell(Text(item['travel_class'])),
                              DataCell(Text(item['route'])),
                              DataCell(
                                Text(
                                    '${item['start_date']} - ${item['end_date']}'),
                              ),
                              DataCell(Text(item['total_sales'].toString())),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePeriodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Select Time Period: ',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(width: 10.0),
        DropdownButton<String>(
          value: _selectedTimePeriod,
          onChanged: _onTimePeriodChanged,
          items: [
            DropdownMenuItem(
              value: 'daily',
              child: Text('Daily'),
            ),
            DropdownMenuItem(
              value: 'weekly',
              child: Text('Weekly'),
            ),
            DropdownMenuItem(
              value: 'monthly',
              child: Text('Monthly'),
            ),
          ],
        ),
      ],
    );
  }
}
