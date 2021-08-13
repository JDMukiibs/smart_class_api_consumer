import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

  StudentReport(){
    this.attentiveScore = 0.0;
    this.sleepingScore = 0.0;
    this.inattentiveScore = 0.0;
  }

  Future<void> getReport() async {

    try {
      // Make the request
      http.Response response = await http.get(Uri.parse('http://10.0.2.2:5000/report')).timeout(const Duration(seconds: 4));
      Map data = jsonDecode(response.body);
      print(data);

      // Get properties from data only if status code returned is 201 otherwise take note of the error
      if (response.statusCode == 201){
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
      }else{
        error = data['error'];
      }
    }
    on TimeoutException catch (e) {
      print("Caught error: $e");
      error = 'Timeout occurred.';
    }
    on SocketException catch (e) {
      print("Caught error: $e");
      error = 'Server unresponsive';
    }

  }

  // This function helps us in the Home screen to determine if we were able to get any data from prefs
  // where prefs will have stored data from our last fetch request onto the phone.
  bool checkReportStatus() {
    if (attentiveScore == 0.0 && inattentiveScore == 0.0 && sleepingScore == 0.0)
      return true;
    else
      return false;
  }

}

double roundDouble(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

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
  print("Multipart file created.");

  request.files.add(multipartFile);
  final response = await request.send().timeout(Duration(seconds: 50));
  print(response.statusCode);
  return response.reasonPhrase;
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}