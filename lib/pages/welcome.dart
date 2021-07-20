import 'package:flutter/material.dart';
import 'package:smart_class_api_consumer/custom_widgets/svg_generator.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 42),
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
                //SizedBox(height: 10.0),
                Container(
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
                Container(
                  color: Colors.cyan[900],
                  child: TextButton(
                    onPressed: () {
                      print("I was pressed!");
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
