import 'package:flutter/material.dart';
import 'package:pokedex/utils/type_color.dart';

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = getTypeColor(type);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: color.withOpacity(0.3),
        label: Text(
          type.toUpperCase(),
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: color),
        ),
      ),
    );
  }
}
