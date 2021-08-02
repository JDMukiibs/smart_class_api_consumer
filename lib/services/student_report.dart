//import 'dart:convert';
//import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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

class StudentReport {
  final double attentiveScore;
  final double sleepingScore;
  final double inattentiveScore;
  // String error = "";

  StudentReport({
    required this.attentiveScore,
    required this.sleepingScore,
    required this.inattentiveScore,
});

  // Future<void> getReport() async {
  //
  //   try {
  //     // Make the request
  //     http.Response response = await http.get(Uri.parse('http://10.0.2.2:5000/reports'));
  //     Map data = jsonDecode(response.body);
  //
  //     // Get properties from data
  //     double attScore = data['attentive'];
  //     double nAttScore = data['inattentive'];
  //     double slpScore = data['sleeping'];
  //     double total = attScore + nAttScore + slpScore;
  //
  //     // Perform necessary calculations and set our properties
  //     attentiveScore = (attScore / total) * 100;
  //     inattentiveScore = (nAttScore / total) * 100;
  //     sleepingScore = (slpScore / total) * 100;
  //   }
  //   catch (e) {
  //     print("Caught error: $e");
  //     error = 'Failed to retrieve data';
  //   }
  //
  // }
  //
  // factory StudentReport.fromJson(Map<String, dynamic> json) {
  //   double attScore = json['attentive'];
  //   double nAttScore = json['inattentive'];
  //   double slpScore = json['sleeping'];
  //   double total = attScore + nAttScore + slpScore;
  //
  //   // Get the percentage
  //   attScore = (attScore / total) * 100;
  //   nAttScore = (nAttScore / total) * 100;
  //   slpScore = (slpScore / total) * 100;
  //   return StudentReport(
  //       attentiveScore: attScore,
  //       inattentiveScore: nAttScore,
  //       sleepingScore: slpScore,
  //   );
  // }

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