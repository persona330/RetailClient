import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:retail/model/EmployeeStore.dart';

class EmployeeStoreService
{
  final String _url = 'http://localhost:8080/employee_store';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<EmployeeStore> getEmployeeStore(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return EmployeeStore.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<EmployeeStore>> getEmployeeStoreList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => EmployeeStore.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<EmployeeStore> addEmployeeStore(EmployeeStore employeeStore) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(employeeStore.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return EmployeeStore.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<EmployeeStore> putEmployeeStore(EmployeeStore employeeStore, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(employeeStore.toJson()));

    if (response.statusCode == 200)
    {
      return EmployeeStore.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteEmployeeStore(int id) async
  {
    final response = await http.delete(Uri.parse(_url + "/$id"), headers: headers);
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return "Запрос удален";
    } else{
      throw Exception('Failed to load server data');
    }
  }
}