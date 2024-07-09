import 'package:flutter/material.dart';

class ThermalViewPage extends StatefulWidget {
  const ThermalViewPage({super.key});

  @override
  State<ThermalViewPage> createState() => _ThermalViewPageState();
}

class _ThermalViewPageState extends State<ThermalViewPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Thermal view"),
    );
  }
}
