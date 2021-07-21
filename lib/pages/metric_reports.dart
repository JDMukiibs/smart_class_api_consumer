import 'package:flutter/material.dart';

class MetricReports extends StatefulWidget {
  const MetricReports({Key? key}) : super(key: key);

  @override
  _MetricReportsState createState() => _MetricReportsState();
}

class _MetricReportsState extends State<MetricReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[50],
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Metric Reports',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            color: Colors.black,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Text("Screen for reports"),
    );
  }
}
