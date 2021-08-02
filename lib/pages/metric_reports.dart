import 'package:flutter/material.dart';
import 'package:smart_class_api_consumer/services/student_report.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MetricReports extends StatefulWidget {
  const MetricReports({Key? key}) : super(key: key);

  @override
  _MetricReportsState createState() => _MetricReportsState();
}

class _MetricReportsState extends State<MetricReports> {
  late Map<dynamic, dynamic> _chartData = {};
  late List<EngagementData> _testChartData = [];
  late StudentReport _studentReport;
  late TooltipBehavior _tooltipBehavior;
  // Future<StudentReport>? _futureStudentReport;

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
        child: (_chartData.isEmpty) ? buildColumn() : buildChart(),
      )
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              _studentReport = StudentReport(attentiveScore: 27.5, sleepingScore: 30.2, inattentiveScore: 42.3);
              _chartData = createChartData(_studentReport);
              _testChartData = makeListOutOfData(_chartData);
              _tooltipBehavior = TooltipBehavior(enable: true);
              print("test");
            });
          },
          child: const Text('Fetch Data', style: TextStyle(fontSize: 28),),
        )
      ],
    );
  }

  SfCircularChart buildChart() {
    return SfCircularChart(
      title: ChartTitle(text: "Engagement Report from Sent Images"),
      legend: Legend(
        isVisible: true,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: _tooltipBehavior,
      series: <CircularSeries>[
        RadialBarSeries<EngagementData, String>(
          dataSource: _testChartData,
          xValueMapper: (EngagementData data,_) => data.classification,
          yValueMapper: (EngagementData data,_) => data.amount,
          dataLabelSettings: DataLabelSettings(isVisible: true,),
          enableTooltip: true,
          maximumValue: 100,
        )
      ],
      annotations: <CircularChartAnnotation>[
        CircularChartAnnotation(
          angle: 0,
          radius: '0%',
          height: '90%',
          width: '90%',
          widget: Container(
            child: iconSelector(_studentReport),
          )
        )
      ],
    );
  }

  Icon iconSelector(StudentReport report){
    if (report.attentiveScore > 70){
      // If the engagement score has the student attentive for 70% of the class
      return Icon(
        Icons.sentiment_satisfied_alt_rounded,
        color: Colors.teal,
        size: 90.0,
        semanticLabel: 'Keep up the good work',
      );
    } else if (report.attentiveScore <= 70 && report.attentiveScore > 50) {
      // If the engagement score has the student being attentive for 50 to 70% of the time
      return Icon(
        Icons.sentiment_neutral,
        color: Colors.grey,
        size: 90.0,
        semanticLabel: "Don't fall behind your classmates",
      );
    } else {
      // Otherwise if they are below 50 in the attentive score then they might have a problem
      return Icon(
        Icons.sentiment_dissatisfied_rounded,
        color: Colors.red,
        size: 90.0,
        semanticLabel: "If you're having any trouble with following the class, please write to the Professor.",
      );
    }
  }

}
