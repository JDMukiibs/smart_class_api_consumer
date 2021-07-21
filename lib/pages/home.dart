import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_class_api_consumer/custom_widgets/svg_generator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(19, 30, 280, 20),
              child: Text(
                'Home',
                style: TextStyle(
                  fontFamily: 'fonts/Poppins-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 10),
              child: InkWell(
                // When the container is tapped navigate to the Report screen
                onTap: () {
                  Navigator.pushNamed(context, '/reports');
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 127,
                  decoration: BoxDecoration(
                    color: Colors.teal[100],
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Metric Report',
                          style: TextStyle(
                            fontFamily: 'fonts/Poppins-Medium',
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(child: metricReportsSVG),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 15),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/images');
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 127,
                  decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Images',
                          style: TextStyle(
                            fontFamily: 'fonts/Poppins-Medium',
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(child: imagesSVG),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 15),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                  height: 127,
                  decoration: BoxDecoration(
                      color: Colors.teal[100],
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Recent Report',
                        style: TextStyle(
                          fontFamily: 'fonts/Poppins-Medium',
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(child: recentSVG),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment(0.0, -1.0),
              child: Row(
                children: [
                  Text(
                    'Footer for shapes',
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
