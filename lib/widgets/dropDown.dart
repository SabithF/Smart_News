import 'package:flutter/material.dart';

GestureDetector dropDown({name, onCalled}) {
  return GestureDetector(
      child: ListTile(title: Text(name)), onTap: () => onCalled());
}
