import 'package:flutter/material.dart';
import 'dart:async';
import 'package:stevens_smartcampus/components/chat_scaffold.dart';


void main() {
  runApp(SmartCampusApp());
}

class SmartCampusApp extends StatelessWidget {
  const SmartCampusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartCampus Shuttle',
      debugShowCheckedModeBanner: false,
      home: ShuttleHomeScreen(),
    );
  }
}

class ShuttleHomeScreen extends StatelessWidget {
  final String backgroundUrl = 'https://i.postimg.cc/Xq0tf6Sn/stevens.png';
  final String logoUrl = 'https://i.postimg.cc/ZRGcQdxZ/logo.png';

  const ShuttleHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(backgroundUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(logoUrl),
                        radius: 28,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'SmartCampus',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Shuttle Services:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: GradientButton(
                      label: 'Schedule',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => HomeScreen(isSchedule: true)),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: GradientButton(
                      label: 'Book',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LocationInputScreen()),
                        );
                      },
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

class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const GradientButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: 280),
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.pink.shade200],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(2, 2),
          )
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isSchedule;

  const HomeScreen({super.key, required this.isSchedule});

  final String logoUrl = 'https://i.postimg.cc/ZRGcQdxZ/logo.png';
  final String backgroundUrl = 'https://i.postimg.cc/Xq0tf6Sn/stevens.png';
  final String mapImageUrl = 'https://i.postimg.cc/vBXLHnGW/Screenshot-2025-04-07-190541.png';

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      appBar: AppBar(
        title: Text('Schedule'),
        leading: BackButton(),
        backgroundColor: Colors.black.withOpacity(0.5),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              backgroundUrl,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Row(
                  children: [
                    Image.network(logoUrl, height: 50),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SmartCampus',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Schedule',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(mapImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        "Pre-book your ride up to 3 hours in advance!",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Note: You can only schedule 3 times a week",
                        style: TextStyle(color: Colors.redAccent, fontSize: 12),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LocationInputScreen(isSchedule: isSchedule)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.blue),
                              SizedBox(width: 12),
                              Text(
                                'Tap to set pickup address',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LocationInputScreen extends StatefulWidget {
  final bool isSchedule;
  const LocationInputScreen({super.key, this.isSchedule = false});
  @override
  State<LocationInputScreen> createState() => _LocationInputScreenState();
}

class _LocationInputScreenState extends State<LocationInputScreen> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final FocusNode _pickupFocus = FocusNode();
  final FocusNode _destinationFocus = FocusNode();

  final List<String> quickOptions = [
    '9th St Light Rail Station',
    '2nd St Light Rail Station',
    'Hoboken Terminal',
    'Hospital',
    'Shipyard',
  ];

  void _handleQuickOptionTap(String address) {
    if (_pickupFocus.hasFocus || _pickupController.text.isEmpty) {
      _pickupController.text = address;
      FocusScope.of(context).requestFocus(_destinationFocus);
    } else if (_destinationFocus.hasFocus || _pickupController.text.isNotEmpty) {
      _destinationController.text = address;
    }
    setState(() {});
  }

  void _bookRide() {
    final pickup = _pickupController.text.trim();
    final destination = _destinationController.text.trim();

    if (pickup.isEmpty || destination.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both pickup and destination')),
      );
      return;
    }
    if (widget.isSchedule) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TimeSlotScreen(pickup: pickup, destination: destination),
      ),
    );
  } else {
    // Go directly to booking confirmation (skip timeslot and queue)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmationScreen(
          message: 'Your ride has been assigned. You will be picked up shortly!',
        ),
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
    super.dispose();
  }

  Widget _presetButton(String label, String address) {
    return ListTile(
      leading: Icon(Icons.location_on),
      title: Text(label),
      subtitle: Text(address),
      onTap: () {
        _pickupController.text = address;
        FocusScope.of(context).requestFocus(_destinationFocus);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      appBar: AppBar(title: Text('Enter Locations'), leading: BackButton()),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _pickupController,
              focusNode: _pickupFocus,
              decoration: InputDecoration(
                labelText: 'Pickup Location',
                prefixIcon: Icon(Icons.my_location),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
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
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 16),
            Text("Preset Locations", style: TextStyle(fontWeight: FontWeight.bold)),
            _presetButton('Home Address', '123 Main St'),
            _presetButton('Work Address', '456 Office Blvd'),
            Divider(),
            Text("Quick Addresses", style: TextStyle(fontWeight: FontWeight.bold)),
            ...quickOptions.map((addr) => ListTile(
                  title: Text(addr),
                  onTap: () => _handleQuickOptionTap(addr),
                )),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.local_taxi),
              label: Text('Book Ride'),
              onPressed: _bookRide,
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSlotScreen extends StatelessWidget {
  final String pickup;
  final String destination;

  TimeSlotScreen({super.key, required this.pickup, required this.destination});

  final List<String> timeSlots = [
    '9:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      appBar: AppBar(title: Text('Select Time Slot'), leading: BackButton()),
      body: ListView.builder(
        itemCount: timeSlots.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(timeSlots[index]),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Ride Booked'),
                  content: Text(
                      'Pickup: $pickup\nDestination: $destination\nTime: ${timeSlots[index]}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => QueueStatusScreen()),
                        );
                      },
                      child: Text('OK'),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class QueueStatusScreen extends StatefulWidget {
  const QueueStatusScreen({super.key});

  @override
  _QueueStatusScreenState createState() => _QueueStatusScreenState();
}


class _QueueStatusScreenState extends State<QueueStatusScreen> {
  int position = 3;
  Timer? timer;

  void _simulateRideConfirmation() {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (position > 1) {
        setState(() => position--);
      } else {
        timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ConfirmationScreen(
              message: 'Your ride has been assigned.',
              imageUrl: 'https://i.postimg.cc/Y9yq8czh/con.png',
            ),
          ),
        );
      }
    });
  }

  void _joinWaitlist() {
    setState(() => position++);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      appBar: AppBar(title: Text('Queue Status'), leading: BackButton()),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.grey[900],
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.3),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Finding Your Nearest Ride!',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 20),
                Icon(Icons.directions_car, size: 50, color: Colors.white),
                SizedBox(height: 20),
                Text('Your position in line is', style: TextStyle(fontSize: 18, color: Colors.white)),
                Text(position.toString().padLeft(2, '0'),
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.redAccent)),
                Text('You will get your confirmation within 15 mins', style: TextStyle(fontSize: 16, color: Colors.white)),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: Icon(Icons.check),
                  label: Text('Book Ride'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
                  onPressed: _simulateRideConfirmation,
                ),
                TextButton(
                  onPressed: _joinWaitlist,
                  child: Text('Someone joined the waitlist', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class ConfirmationScreen extends StatelessWidget {
  final String title;
  final String message;
  final String imageUrl;

  const ConfirmationScreen({
    this.title = 'Ride Confirmed!',
    required this.message,
    this.imageUrl = 'https://i.postimg.cc/Y9yq8czh/con.png',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  message,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: Icon(Icons.home),
                  label: Text('Back to Home'),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

