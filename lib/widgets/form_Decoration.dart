import 'package:flutter/material.dart';

final FormDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.teal,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10)),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.tealAccent,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10)),
  errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(10)),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 2,
    ),
    borderRadius: BorderRadius.circular(10),
  ),
  fillColor: Colors.white,
  filled: true,
);
