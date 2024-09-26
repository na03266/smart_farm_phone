import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final double sensorData;

  const SensorCard({
    super.key,
    required this.sensorData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Text('$sensorData')
          ],
        ),
      ),
    );
  }
}
