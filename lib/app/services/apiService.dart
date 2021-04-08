import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task/app/model/employeeModel.dart';

 class ApiService  {

  Future<List<Employee>> loadLocalJsonData() async {
    try {
      List<Employee> list = [];
      var response = await rootBundle.loadString("assets/employees.json");
      print('----------------------DATA');
      var d = json.decode(response);
      if (d is List) {
        //list = d.map((emp) => Employee.fromJson(emp)).toList();
      }
      print(list);
      print("+++++++++++++++++++++++++++++++++++++++++++++++++++");
      return list;

      /// return data.map((job) => new Employee.fromJson(job)).toList();
    } catch (e) {
      print(e);
      print("erorrrrrrrrrrrrrrrrrrrrrrrrrrr");
    }
  }
}
