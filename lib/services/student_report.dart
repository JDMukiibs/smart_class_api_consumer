import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

// This class helps us when developing the chartData list for the chart visualization of results
class EngagementData {
  final String classification;
  final double amount;

  EngagementData({required this.classification, required this.amount});
}

List<EngagementData> makeListOutOfData(Map<dynamic, dynamic> report){
  final List<EngagementData> eData = [];

  report.forEach((key, value) {
    eData.add(EngagementData(classification: key, amount: value));
  });

  return eData;
}

// This class helps us store the classification results from the server
class StudentReport {
  late double attentiveScore;
  late double sleepingScore;
  late double inattentiveScore;
  String error = "";

  StudentReport();

  Future<void> getReport() async {

    try {
      // Make the request
      http.Response response = await http.get(Uri.parse('http://10.0.2.2:5000/report'));
      Map data = jsonDecode(response.body);
      print(data);

      // Get properties from data
      double attScore = data['attentive'].toDouble();
      double nAttScore = data['inattentive'].toDouble();
      double slpScore = data['sleeping'].toDouble();
      double total = attScore + nAttScore + slpScore;
      print(total);

      // Perform necessary calculations and set our properties
      attentiveScore = roundDouble(((attScore / total) * 100.0), 2);
      inattentiveScore = roundDouble(((nAttScore / total) * 100.0), 2);
      sleepingScore = roundDouble(((slpScore / total) * 100.0), 2);
      error = ""; // Ensure error is returned to empty string so the if clause check passes when we try again
    }
    catch (e) {
      print("Caught error: $e");
      error = 'Failed to retrieve data';
    }

  }

}

double roundDouble(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

// Future <StudentReport>? fetchReport() async {
//   final response = await http.get(Uri.parse('http://10.0.2.2:5000/reports'));
//
//   if (response.statusCode == 200) {
//     // If the server returns a 200 OK response, then we parse the json
//     return StudentReport.fromJson(jsonDecode(response.body));
//   } else {
//     // we throw an exception to let us know something went wrong.
//     throw Exception("Failed to load report!");
//   }
// }

Map<dynamic, dynamic> createChartData(StudentReport studentData){
  var details = new Map();
  details['attentive'] = studentData.attentiveScore;
  details['inattentive'] = studentData.inattentiveScore;
  details['sleeping'] = studentData.sleepingScore;
  return details;
}

Future<String?> uploadImage(filename) async {
  print("Attempting to connect to server...");

  var stream = new http.ByteStream(filename.openRead());
  stream.cast();
  var length = await filename.length();
  print(length);

  var uri = Uri.parse('http://10.0.2.2:5000/upload');
  print("Connection established.");

  var request = http.MultipartRequest('POST', uri);
  var multipartFile = new http.MultipartFile('picture', stream, length, filename: basename(filename.path));

  request.files.add(multipartFile);
  final response = await request.send();
  print(response.statusCode);
  return response.reasonPhrase;

  // if (response.statusCode == 201) {
  //   // If the server did return a 201 CREATED response,
  //   // then parse the JSON.
  //   return response.reasonPhrase;
  // } else {
  //   // If the server did not return a 201 CREATED response,
  //   // then throw an exception.
  //   throw Exception('Failed to create album.');
  // }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}