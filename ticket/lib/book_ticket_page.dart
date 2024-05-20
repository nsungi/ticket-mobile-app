import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'payment.dart';

class BookTicketPage extends StatefulWidget {
  @override
  _BookTicketPageState createState() => _BookTicketPageState();
}

class _BookTicketPageState extends State<BookTicketPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passengerNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  DateTime _selectedBookingDate = DateTime.now();
  DateTime? _selectedTravelDate;
  String _selectedGender = 'Male';
  String _selectedTravelClass = 'Economy';
  String _selectedSeatNumber = 'A1';
  String _selectedRoute = 'From Mbeya to Kigoma';

  List<String> _genderChoices = ['Male', 'Female'];
  List<String> _classChoices = ['Economy', 'Business', 'First Class'];
  List<String> _seatChoices = ['A1', 'B2', 'C2', 'D2', 'E2'];
  List<String> _routeChoices = [
    'From Mbeya to Kigoma',
    'From Mbeya to Dar',
    'From Dar to Mwanza',
    'From Dar to Kigoma'
  ];

  String _mapGenderToShortForm(String gender) {
    if (gender == 'Male') {
      return 'M';
    } else if (gender == 'Female') {
      return 'F';
    }
    return '';
  }

  Future<void> _submitTicketBooking() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://192.168.1.116:8000/main/tickets/create/';
      final passengerName = _passengerNameController.text;
      final phoneNumber = _phoneNumberController.text;

      final body = json.encode({
        'passenger': passengerName,
        'passenger_phone_number': phoneNumber,
        'gender': _mapGenderToShortForm(_selectedGender),
        'travel_class': _selectedTravelClass,
        'seat_number': _selectedSeatNumber,
        'travel_date': DateFormat('yyyy-MM-dd').format(_selectedTravelDate!),
        'route': _selectedRoute,
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        print('Booking successful.');
        final responseData = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(bookingData: responseData),
          ),
        );
      } else {
        print('Booking failed. Please try again.');
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    }
  }

  Future<void> _selectTravelDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedTravelDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Ticket'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _passengerNameController,
                      decoration: InputDecoration(
                        labelText: 'Passenger Name',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter passenger name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: UnderlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Booking Date',
                        border: UnderlineInputBorder(),
                      ),
                      controller: TextEditingController(
                        text: DateFormat('yyyy-MM-dd')
                            .format(_selectedBookingDate),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _selectTravelDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Travel Date',
                            border: UnderlineInputBorder(),
                          ),
                          controller: TextEditingController(
                            text: _selectedTravelDate != null
                                ? DateFormat('yyyy-MM-dd')
                                    .format(_selectedTravelDate!)
                                : '',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select travel date';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedRoute,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedRoute = newValue!;
                        });
                      },
                      items: _routeChoices.map((route) {
                        return DropdownMenuItem(
                          child: Text(route),
                          value: route,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Route',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedGender = newValue!;
                        });
                      },
                      items: _genderChoices.map((gender) {
                        return DropdownMenuItem(
                          child: Text(gender),
                          value: gender,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedTravelClass,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedTravelClass = newValue!;
                        });
                      },
                      items: _classChoices.map((travelClass) {
                        return DropdownMenuItem(
                          child: Text(travelClass),
                          value: travelClass,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Travel Class',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _selectedSeatNumber,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedSeatNumber = newValue!;
                        });
                      },
                      items: _seatChoices.map((seatNumber) {
                        return DropdownMenuItem(
                          child: Text(seatNumber),
                          value: seatNumber,
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Seat Number',
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _submitTicketBooking,
                        child: Text(
                          'Book Ticket',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 15),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
