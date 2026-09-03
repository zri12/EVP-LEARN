import 'package:flutter/material.dart';

abstract final class AppRadius {
  static const small = BorderRadius.all(Radius.circular(10));
  static const button = BorderRadius.all(Radius.circular(14));
  static const card = BorderRadius.all(Radius.circular(16));
  static const heroCard = BorderRadius.all(Radius.circular(20));
  static const bottomSheet = BorderRadius.vertical(top: Radius.circular(24));
}
