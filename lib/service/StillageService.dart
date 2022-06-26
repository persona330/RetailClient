import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../model/Stillage.dart';

class StillageService
{
  final String _url = 'http://localhost:8080/stillage';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<Stillage> getStillage(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return Stillage.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Stillage>> getStillageList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Stillage.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Stillage> addStillage(Stillage stillage) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(stillage.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return Stillage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Stillage> putStillage(Stillage stillage, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(stillage.toJson()));

    if (response.statusCode == 200)
    {
      return Stillage.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteStillage(int id) async
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