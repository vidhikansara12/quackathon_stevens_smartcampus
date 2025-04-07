import 'package:flutter/material.dart';
import 'dart:async';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Controllers & FocusNodes for Location Input
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _pickupFocus = FocusNode();
  final FocusNode _destinationFocus = FocusNode();

  // Quick address options (used in the Location Input section)
  final List<String> quickOptions = [
    '9th St Light Rail Station',
    '2nd St Light Rail Station',
    'Hoboken Terminal',
    'Hospital',
    'Shipyard',
  ];

  // For the Queue Status simulation
  int position = 3;
  Timer? timer;
  bool _bookingStarted = false;

  // For the Schedule Section
  String? selectedTime;
  final List<String> availableTimes = ['5:30', '5:45', '6:00'];

  // --- Location Input Methods ---
  void _handleQuickOptionTap(String address) {
    if (_pickupFocus.hasFocus || _pickupController.text.isEmpty) {
      _pickupController.text = address;
      FocusScope.of(context).requestFocus(_destinationFocus);
    } else {
      _destinationController.text = address;
    }
    setState(() {});
  }

  Widget _buildPresetButton(String label, String address) {
    return ListTile(
      leading: Icon(Icons.location_on, color: Colors.white),
      title: Text(label, style: TextStyle(color: Colors.white)),
      subtitle: Text(address, style: TextStyle(color: Colors.white70)),
      onTap: () {
        _pickupController.text = address;
        FocusScope.of(context).requestFocus(_destinationFocus);
        setState(() {});
      },
    );
  }

  // --- Booking & Queue Simulation Methods ---
  void _bookRide() {
    final pickup = _pickupController.text.trim();
    final destination = _destinationController.text.trim();
    if (pickup.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both pickup and destination')),
      );
      return;
    }
    // Start the booking simulation
    setState(() {
      _bookingStarted = true;
      position = 3; // reset position
    });
    _simulateRideConfirmation();
  }

  void _simulateRideConfirmation() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (position > 1) {
        setState(() {
          position--;
        });
      } else {
        timer.cancel();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Ride Confirmed!'),
            content: Text('Your ride has been assigned.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Optionally, reset booking simulation here if needed
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
    });
  }

  void _joinWaitlist() {
    setState(() {
      position++;
    });
  }

  // --- Schedule Section Methods ---
  void _selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  Widget _buildTimeSlot(String time) {
    final isSelected = time == selectedTime;
    return ElevatedButton(
      onPressed: () => _selectTime(time),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.red : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(color: Colors.redAccent, width: 1),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        elevation: 3,
      ),
      child: Text(
        time,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.red,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  void _bookSlot() {
    if (selectedTime != null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Booking Confirmed!'),
          content: Text('Your slot at $selectedTime is confirmed.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _destinationController.dispose();
    _pickupFocus.dispose();
    _destinationFocus.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a background image for the entire screen
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://i.postimg.cc/Xq0tf6Sn/stevens.png',
              fit: BoxFit.cover,
            ),
          ),
          // Dark overlay for better contrast
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'SmartCampus Ride',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(4.0, 4.0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '3:00',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(3.0, 3.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // LOCATION INPUT SECTION
                  TextField(
                    controller: _pickupController,
                    focusNode: _pickupFocus,
                    decoration: InputDecoration(
                      labelText: 'Pickup Location',
                      prefixIcon: Icon(Icons.my_location),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(_pickupFocus);
                    },
                    onSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_destinationFocus);
                    },
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _destinationController,
                    focusNode: _destinationFocus,
                    decoration: InputDecoration(
                      labelText: 'Destination Location',
                      prefixIcon: Icon(Icons.place),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(_destinationFocus);
                    },
                  ),
                  SizedBox(height: 16),
                  Text("Preset Locations",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  _buildPresetButton('Home Address', '123 Main St'),
                  _buildPresetButton('Work Address', '456 Office Blvd'),
                  Divider(color: Colors.white),
                  Text("Quick Addresses",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  ...quickOptions.map((addr) => ListTile(
                        title:
                            Text(addr, style: TextStyle(color: Colors.white)),
                        onTap: () => _handleQuickOptionTap(addr),
                      )),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Icon(Icons.local_taxi),
                    label: Text('Book Ride'),
                    onPressed: _bookRide,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                    ),
                  ),
                  SizedBox(height: 30),

                  // QUEUE STATUS SECTION (visible if booking started)
                  if (_bookingStarted) ...[
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Finding Your Nearest Ride!',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 20),
                          Icon(Icons.directions_car,
                              size: 50, color: Colors.white),
                          SizedBox(height: 20),
                          Text('Your position in line is',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          Text(
                            position.toString().padLeft(2, '0'),
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          ),
                          Text(
                            'You will get your confirmation within 15 mins',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton.icon(
                            icon: Icon(Icons.check),
                            label: Text('Confirm Ride'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                            ),
                            onPressed: _simulateRideConfirmation,
                          ),
                          TextButton(
                            onPressed: _joinWaitlist,
                            child: Text(
                              'Someone joined the waitlist',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],

                  // SCHEDULE SECTION
                  Text("Schedule",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2)),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Available Time Slots:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 16,
                    runSpacing: 10,
                    children: availableTimes
                        .map((time) => _buildTimeSlot(time))
                        .toList(),
                  ),
                  if (selectedTime != null) ...[
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _bookSlot,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        textStyle:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text('Book Now'),
                    ),
                  ],
                  SizedBox(height: 30),
                  // Chat Button (FAB style)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 24,
                      child: Icon(Icons.chat, color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
