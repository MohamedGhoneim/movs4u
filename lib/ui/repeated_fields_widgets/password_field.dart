import 'package:flutter/material.dart';
// Create Password TextField
Widget passwordField(dynamic bloc,String hint,String label,TextEditingController controller) {
  return StreamBuilder<String>(
    stream: bloc.password,
    builder: (context, snapshot) => TextField(
      controller: controller,
      onChanged: bloc.passwordChanged,
      keyboardType: TextInputType.text,
      obscureText: true,
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
        prefixIcon: Icon(Icons.lock, color: Colors.black87, size: 25.0),
        contentPadding: EdgeInsets.all(5.0),
      ),
    ),
  );
}