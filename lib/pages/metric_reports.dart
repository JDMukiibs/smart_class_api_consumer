import 'package:flutter/material.dart';
import 'package:smart_class_api_consumer/services/student_report.dart';

class MetricReports extends StatefulWidget {
  const MetricReports({Key? key}) : super(key: key);

  @override
  _MetricReportsState createState() => _MetricReportsState();
}

class _MetricReportsState extends State<MetricReports> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

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
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      )
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          controller: _controller,
          decoration: const InputDecoration(hintText: 'Enter Title'),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum = createAlbum(_controller.text);
            });
          },
          child: const Text('Create Data'),
        )
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.title);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

}
