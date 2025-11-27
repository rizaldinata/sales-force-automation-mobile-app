import 'package:flutter/material.dart';

class MenuModel {
  final String label;
  final IconData icon;
  final int? actionCode;

  MenuModel({required this.label, required this.icon, this.actionCode});
}
