import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:retail/model/Area.dart';

class AreaService
{
  final String _url = 'http://localhost:8080/area';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<Area> getArea(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return Area.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Area>> getAreaList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Area.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Area> addArea(Area area) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(area.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return Area.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Area> putArea(Area area, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(area.toJson()));

    if (response.statusCode == 200)
    {
      return Area.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteArea(int id) async
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