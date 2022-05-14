import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import '../model/Measurement.dart';

class MeasurementService
{
  final String _url = 'http://localhost:8080/measurement';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<Measurement> getMeasurement(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return Measurement.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Measurement>> getMeasurementList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Measurement.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Measurement> addMeasurement(Measurement measurement) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(measurement.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return Measurement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Measurement> putMeasurement(Measurement measurement, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(measurement.toJson()));

    if (response.statusCode == 200)
    {
      return Measurement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteMeasurement(int id) async
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