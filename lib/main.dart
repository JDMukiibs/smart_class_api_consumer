import 'package:flutter/material.dart';
import 'package:smart_class_api_consumer/pages/home.dart';
import 'package:smart_class_api_consumer/pages/metric_reports.dart';
import 'package:smart_class_api_consumer/pages/send_images.dart';
import 'package:smart_class_api_consumer/pages/welcome.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(fontFamily: 'Poppins', accentColor: Colors.teal),
  debugShowCheckedModeBanner: false,
  initialRoute: '/',
  routes: {
    '/': (context) => Welcome(),
    '/home': (context) => Home(),
    '/reports': (context) => MetricReports(),
    '/images': (context) => SendImages(),
  },
));



