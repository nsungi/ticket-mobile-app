import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'payment.dart';

// Model representing each seat
class Seat {
  final String number;
  bool available;
  DateTime? bookingTime;

  Seat({required this.number, required this.available, this.bookingTime});
}

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
  TimeOfDay? _selectedTravelTime;
  String _selectedGender = 'Male';
  String _selectedTravelClass = 'Economy';
  String _selectedRoute = 'From Dar to Moro';
  String _selectedSeatNumber = 'B1'; // Default seat number

  List<String> _genderChoices = ['Male', 'Female'];
  List<String> _classChoices = ['Economy', 'Standard', 'Business'];
  List<String> _routeChoices = [
    'From Dar to Moro',
    'From Dar to Charinze',
    'From Moro to Charinze',
    'From Moro to Dar'
  ];

  late List<Seat> _seats;

  @override
  void initState() {
    super.initState();
    // Initialize seats
    _seats = _generateSeats();
  }

  // Method to generate list of seats
  List<Seat> _generateSeats() {
    List<Seat> seats = [];
    List<String> seatNumbers = [
      'B1',
      'B2',
      'B3',
      'B4',
      'B5',
      'B6',
      'S1',
      'S2',
      'S3',
      'S4',
      'S5',
      'S6',
      'E1',
      'E2',
      'E3',
      'E4',
      'E5',
      'E6'
    ];
    // Initialize all seats as available
    for (String number in seatNumbers) {
      seats.add(Seat(number: number, available: true));
    }
    return seats;
  }

  Future<void> _submitTicketBooking() async {
    if (_formKey.currentState!.validate()) {
      final url = 'http://192.168.1.115:8000/api/main/tickets/create/';
      final passengerName = _passengerNameController.text;
      final phoneNumber = _phoneNumberController.text;
      final travelDateTime = DateTime(
        _selectedTravelDate!.year,
        _selectedTravelDate!.month,
        _selectedTravelDate!.day,
        _selectedTravelTime!.hour,
        _selectedTravelTime!.minute,
      );

      final body = json.encode({
        'passenger': passengerName,
        'passenger_phone_number': phoneNumber,
        'gender':
            _selectedGender == 'Male' ? 'M' : 'F', // Map gender to model value
        'travel_class': _selectedTravelClass,
        'route': _selectedRoute,
        'travel_date': DateFormat('yyyy-MM-dd HH:mm').format(travelDateTime),
        'seat_number': _selectedSeatNumber,
        'seat_class': _selectedTravelClass, // Use travel class as seat class
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
        setState(() {
          // Find the booked seat and mark it as unavailable
          for (Seat seat in _seats) {
            if (seat.number == _selectedSeatNumber) {
              seat.available = false;
              seat.bookingTime = DateTime.now();
              break;
            }
          }
        });
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
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedTravelDate = pickedDate;
          _selectedTravelTime = pickedTime;
        });
      }
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
                        text: DateFormat('yyyy-MM-dd HH:mm')
                            .format(_selectedBookingDate),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => _selectTravelDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Travel Date and Time',
                            border: UnderlineInputBorder(),
                          ),
                          controller: TextEditingController(
                            text: _selectedTravelDate != null &&
                                    _selectedTravelTime != null
                                ? DateFormat('yyyy-MM-dd HH:mm').format(
                                    DateTime(
                                        _selectedTravelDate!.year,
                                        _selectedTravelDate!.month,
                                        _selectedTravelDate!.day,
                                        _selectedTravelTime!.hour,
                                        _selectedTravelTime!.minute))
                                : '',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select travel date and time';
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
                      items: _seats.map((seat) {
                        // Determine the color of the seat based on its availability
                        bool isSixHoursPassed = seat.bookingTime != null &&
                            DateTime.now()
                                    .difference(seat.bookingTime!)
                                    .inHours >=
                                6;
                        bool clickable = seat.available || isSixHoursPassed;
                        Color seatColor = clickable ? Colors.green : Colors.red;

                        return DropdownMenuItem(
                          child: Text(
                            '${seat.number} (${clickable ? 'Available' : 'Booked'})',
                            style: TextStyle(
                              color: seatColor,
                              decoration: clickable
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough,
                            ),
                          ),
                          value: seat.number,
                          enabled: clickable,
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
