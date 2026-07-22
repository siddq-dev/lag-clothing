import 'package:flutter/material.dart';

class FeatureData {
  final IconData icon;
  final String title;
  final String description;

  const FeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

const List<FeatureData> features = [
  FeatureData(
    icon: Icons.local_shipping_outlined,
    title: 'Fast Delivery',
    description: 'Quick and reliable shipping across India.',
  ),

  FeatureData(
    icon: Icons.verified_outlined,
    title: 'Premium Quality',
    description: 'High-quality jerseys with premium fabrics.',
  ),

  FeatureData(
    icon: Icons.lock_outline,
    title: 'Secure Payment',
    description: 'Safe and secure online payment options.',
  ),

  FeatureData(
    icon: Icons.support_agent,
    title: '24/7 Support',
    description: 'Friendly customer support whenever you need us.',
  ),
];