// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

List<Employee> employeeFromJson(String str) =>
    List<Employee>.from(json.decode(str).map((x) => Employee.fromJson(x)));

String employeeToJson(List<Employee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employee {
  Employee({
    this.id,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.email,
    this.contactNumber,
    this.age,
    this.dob,
    this.salary,
    this.address,
  });
  String count;
  int id;
  String imageUrl;
  String firstName;
  String lastName;
  String email;
  String contactNumber;
  int age;
  String dob;
  int salary;
  String address;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        imageUrl: json["imageUrl"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        contactNumber: json["contactNumber"],
        age: json["age"],
        dob: json["dob"],
        salary: json["salary"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageUrl": imageUrl,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "contactNumber": contactNumber,
        "age": age,
        "dob": dob,
        "salary": salary,
        "address": address,
      };

  static List<Employee> fromJsonList(jsonList) {
    return jsonList.map<Employee>((obj) => Employee.fromJson(obj)).toList();
  }
}
