import 'dart:convert';

import 'package:http/http.dart';
import 'package:vizmo/models/sortby.dart';

class Employee {
  final int id;
  final String name;
  final String email;
  final String contactNumber;
  final String photoUrl;
  final DateTime birthday;
  final String country;
  final List departments;
  final DateTime createdAt;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.contactNumber,
    required this.photoUrl,
    required this.birthday,
    required this.country,
    required this.departments,
    required this.createdAt,
  });

  static Employee fromMap(Map map) {
    return Employee(
      id: int.parse(map['id']),
      name: map['name'],
      email: map['email'],
      contactNumber: map['phone'],
      photoUrl: map['avatar'],
      birthday: DateTime.parse(map['birthday']),
      country: map['country'],
      departments: map['department'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  static Future<List<Employee>> getAll() async {
    Uri uri =
        Uri.parse("https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee");
    Response response = await get(uri);
    List decodedResponse = jsonDecode(response.body);
    List<Employee> result = decodedResponse.map((e) => fromMap(e)).toList();
    return result;
  }

  static Future<List<Employee>> getByPage(int pageNo, SortBy sortBy) async {
    String url =
        "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee?page=$pageNo&limit=10&sortby=${sortBy.name}";
    print(url);
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    List decodedResponse = jsonDecode(response.body);
    List<Employee> result = decodedResponse.map((e) => fromMap(e)).toList();
    return result;
  }

  static Future<List<Employee>> search(String keyword) async {
    String url =
        "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee?filter=$keyword";
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
    var decodedResponse = jsonDecode(response.body);
    if (decodedResponse is String) {
      return [];
    }
    List<Employee> result =
        decodedResponse.map<Employee>((e) => fromMap(e)).toList();
    return result;
  }
}
