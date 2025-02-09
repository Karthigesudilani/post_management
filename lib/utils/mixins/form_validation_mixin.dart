import 'package:flutter/material.dart';

mixin FormValidationMixin {
  String? validateTitle(String? value) {
    if (value == null || value.isEmpty) return 'Title is required';
    if (value.length < 3 || value.length > 50) return 'Title must be between 3 and 50 characters';
    return null;
  }

  String? validateDescription(String? value) {
    if (value == null || value.isEmpty) return 'Description is required';
    if (value.length < 10 || value.length > 500) return 'Description must be between 10 and 500 characters';
    return null;
  }

  InputDecoration inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      alignLabelWithHint: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
