import 'package:flutter/material.dart';
import 'package:map_example/widgets/custom_google_map_widget.dart';

void main() {
  runApp(const FlutterMapExample());
}

class FlutterMapExample extends StatelessWidget {
  const FlutterMapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomGoogleMapWidget(),
    );
  }
}
