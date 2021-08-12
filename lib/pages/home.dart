import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_class_api_consumer/helper_widgets_and_functions/shapes.dart';
import 'package:smart_class_api_consumer/helper_widgets_and_functions/svg_generator.dart';
import 'package:smart_class_api_consumer/services/student_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final StudentReport _studentReport = StudentReport();
  late Map<dynamic, dynamic> _chartData = {};
  late List<EngagementData> _testChartData = [];
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _loadStoredData();
    super.initState();
  }

  void _loadStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      //read data stored with help of Shared Prefs. If it doesn't exist return 0.0
      _tooltipBehavior = TooltipBehavior(enable: true);
      _studentReport.attentiveScore = prefs.getDouble('attentive') ?? 0.0;
      _studentReport.inattentiveScore = prefs.getDouble('inattentive') ?? 0.0;
      _studentReport.sleepingScore = prefs.getDouble('sleeping') ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      body: SafeArea(
        child: CustomPaint(
          painter: CirclePainter(),
          child: Container(
            height: (MediaQuery.of(context).size.height-20),
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
                      height: (MediaQuery.of(context).size.height-200)/5,
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
                      height: (MediaQuery.of(context).size.height-200)/5,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 15),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                    height: (MediaQuery.of(context).size.height - 220)/2,
                    decoration: BoxDecoration(
                        color: Colors.cyan[50],
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
                        SizedBox(height: 30),
                        Expanded(
                            child: (_studentReport.checkReportStatus())
                                ? Text(
                              "No recent report to show. Click Metric Report to fetch some data. Or, add some images and get a report",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )
                                : buildChart()
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget buildChart() {
    _loadStoredData();
    _chartData = createChartData(_studentReport);
    _testChartData = makeListOutOfData(_chartData);

    return SfCircularChart(
      palette: <Color>[Colors.teal[900] as Color, Colors.teal, Colors.teal[200] as Color],
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        PieSeries<EngagementData, String>(
          dataSource: _testChartData,
          xValueMapper: (EngagementData data,_) => data.classification.capitalize(),
          yValueMapper: (EngagementData data,_) => data.amount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          enableTooltip: true,
        )
      ],
    );
  }
}
