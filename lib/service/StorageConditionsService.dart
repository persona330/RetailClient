import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../model/StorageConditions.dart';

class StorageConditionsService
{
  final String _url = 'http://localhost:8080/storage_conditions';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<StorageConditions> getStorageConditions(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return StorageConditions.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<StorageConditions>> getStorageConditionsList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => StorageConditions.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<StorageConditions> addStorageConditions(StorageConditions storageConditions) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(storageConditions.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return StorageConditions.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<StorageConditions> putStorageConditions(StorageConditions storageConditions, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(storageConditions.toJson()));

    if (response.statusCode == 200)
    {
      return StorageConditions.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteStorageConditions(int id) async
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