import 'dart:convert';

import 'package:vizmo/models/employee.dart';
import 'package:http/http.dart';

class Checkin {
  final int id;
  final DateTime time;
  final String location;
  final String purpose;

  Checkin({
    required this.id,
    required this.time,
    required this.location,
    required this.purpose,
  });

  static Checkin fromMap(Map map) {
    return Checkin(
      id: int.parse(map['id']),
      time: DateTime.parse(map['checkin']),
      location: map['location'],
      purpose: map['purpose'],
    );
  }

  static Future<List<Checkin>> historyOfEmployee(Employee employee) async {
    String url =
        "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee/${employee.id}/checkin";
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse is String) {
      return [];
    }
    List<Checkin> result =
        decodedResponse.map<Checkin>((e) => fromMap(e)).toList();
    return result;
  }
}
