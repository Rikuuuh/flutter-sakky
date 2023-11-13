// Malli, jonka pohjalta generoidaan kategorioita

import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    // Orange on oletusväri, jos ei sitä määritellä
    this.color = Colors.orange,
  });

  final String id;
  final String title;
  final Color color;
}
