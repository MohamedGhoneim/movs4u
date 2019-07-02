import 'package:flutter/material.dart';

// Create Optional TextField
Widget optionalField(String hint, String label, TextEditingController controller, TextInputType keyboardType,IconData icon) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      border: new OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: new BorderSide(
          color: Colors.white,
        ),
      ),
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      labelText: label,
      prefixIcon:
          Icon(icon, color: Colors.black87, size: 25.0),
      contentPadding: EdgeInsets.all(5.0),
    ),
  );
}
