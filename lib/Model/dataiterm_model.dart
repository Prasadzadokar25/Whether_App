import 'package:flutter/material.dart';

class DataIterm {
  final String label;
  final String value;
  final String? unit;
  final Widget? icon;
  final String? launchUrl;

  const DataIterm({
    required this.label,
    required this.value,
    this.unit,
    this.icon,
    this.launchUrl,
  });
}
