import 'package:flutter/material.dart';
// Create Name TextField
Widget nameField(dynamic bloc,String hint,String label,TextEditingController controller) {
  return StreamBuilder<String>(
    stream: bloc.name,
    builder: (context, snapshot) => TextField(
      controller: controller,
      onChanged: bloc.nameChanged,
      keyboardType: TextInputType.text,
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
        errorText: snapshot.error,
        prefixIcon: Icon(Icons.person, color: Colors.black87, size: 25.0),
        contentPadding: EdgeInsets.all(5.0),
      ),
    ),
  );
}