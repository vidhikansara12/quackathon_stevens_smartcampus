import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:stevens_smartcampus/components/chat_scaffold.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  double _zoomLevel = 1.0;
  final TransformationController _transformationController =
      TransformationController();

  void _zoomIn() {
    setState(() {
      _zoomLevel = math.min(3.0, _zoomLevel + 0.2);
      _transformationController.value = Matrix4.identity()..scale(_zoomLevel);
    });
  }

  void _zoomOut() {
    setState(() {
      _zoomLevel = math.max(1.0, _zoomLevel - 0.2);
      _transformationController.value = Matrix4.identity()..scale(_zoomLevel);
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChatScaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search the location you want to view.",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 300,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/images/map_image.jpeg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.zoom_in, color: Colors.redAccent),
                    onPressed: _zoomIn,
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.zoom_out, color: Colors.redAccent),
                    onPressed: _zoomOut,
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.location_on, color: Colors.redAccent),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Previously viewed:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/previous_view.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}