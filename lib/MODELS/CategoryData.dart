import 'package:flutter/cupertino.dart';

class CategoryData {
  final String id;

  final String name;

  final String image;

  final String darkimage;

  final IconData icon;

  CategoryData({
    required this.id,
    required this.name,
    required this.image,
    required this.icon,
    required this.darkimage,
  });
}
