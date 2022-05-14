import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../model/VerticalSections.dart';

class VerticalSectionsService
{
  final String _url = 'http://localhost:8080/vertical_sections';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<VerticalSections> getVerticalSections(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return VerticalSections.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<VerticalSections>> getVerticalSectionsList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => VerticalSections.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<VerticalSections> addVerticalSections(VerticalSections verticalSections) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(verticalSections.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return VerticalSections.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<VerticalSections> putVerticalSections(VerticalSections verticalSections, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(verticalSections.toJson()));

    if (response.statusCode == 200)
    {
      return VerticalSections.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteVerticalSections(int id) async
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