import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../model/Shelf.dart';

class ShelfService
{
  final String _url = 'http://localhost:8080/shelf';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<Shelf> getShelf(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return Shelf.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Shelf>> getShelfList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Shelf.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Shelf> addShelf(Shelf shelf) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(shelf.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return Shelf.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Shelf> putShelf(Shelf shelf, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(shelf.toJson()));

    if (response.statusCode == 200)
    {
      return Shelf.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteShelf(int id) async
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