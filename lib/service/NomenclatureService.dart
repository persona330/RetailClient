import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:retail/model/Nomenclature.dart';

class NomenclatureService
{
  final String _url = 'http://localhost:8080/nomenclature';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<Nomenclature> getNomenclature(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return Nomenclature.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Nomenclature>> getNomenclatureList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Nomenclature.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Nomenclature> addNomenclature(Nomenclature nomenclature) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(nomenclature.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return Nomenclature.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Nomenclature> putNomenclature(Nomenclature nomenclature, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(nomenclature.toJson()));

    if (response.statusCode == 200)
    {
      return Nomenclature.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteNomenclature(int id) async
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