import 'package:flutter/material.dart';
import 'contact_form_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Form App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactFormPage(),
    );
  }
}
