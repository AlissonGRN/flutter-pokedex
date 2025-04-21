import 'package:flutter/material.dart';

Color getTypeColor(String type) {
  const typeColors = {
    'fire': Colors.orange,
    'water': Colors.blue,
    'grass': Colors.green,
    'electric': Colors.yellow,
    'psychic': Colors.purple,
    'ice': Colors.cyan,
    'dragon': Colors.indigo,
    'dark': Colors.brown,
    'fairy': Colors.pink,
    'normal': Colors.grey,
    'fighting': Colors.deepOrange,
    'flying': Colors.lightBlue,
    'poison': Colors.deepPurple,
    'ground': Colors.brown,
    'rock': Colors.grey,
    'bug': Colors.lightGreen,
    'ghost': Colors.deepPurple,
    'steel': Colors.blueGrey,
  };

  return typeColors[type] ?? Colors.grey;
}
