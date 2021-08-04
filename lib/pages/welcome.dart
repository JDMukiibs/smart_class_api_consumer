import 'package:flutter/material.dart';
import 'package:smart_class_api_consumer/helper_widgets_and_functions/shapes.dart';
import 'package:smart_class_api_consumer/helper_widgets_and_functions/svg_generator.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: SafeArea(
        child: CustomPaint(
          painter: CurvePainter(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 90),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 35,
                    child: Text(
                      'Smart Class',
                      style: TextStyle(
                        fontFamily: 'fonts/Poppins-Bold',
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //SizedBox(height: 20.0),
                  Expanded(child: welcomeSVG),
                  SizedBox(height: 10.0),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Track your students\' engagement during class',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'fonts/Poppins-Regular',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //SizedBox(height: 20.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: Text(
                      'Let\'s Go!',
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontFamily: 'fonts/Poppins-Medium',
                        letterSpacing: 2.0,
                      ),
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.teal),
                          )
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
