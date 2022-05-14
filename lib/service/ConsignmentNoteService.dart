import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:retail/model/ConsignmentNote.dart';

class ConsignmentNoteService
{
  final String _url = 'http://localhost:8080/consignment_note';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<ConsignmentNote> getConsignmentNote(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return ConsignmentNote.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<ConsignmentNote>> getConsignmentNoteList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => ConsignmentNote.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<ConsignmentNote> addConsignmentNote(ConsignmentNote consignmentNote) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(consignmentNote.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return ConsignmentNote.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<ConsignmentNote> putConsignmentNote(ConsignmentNote consignmentNote, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(consignmentNote.toJson()));

    if (response.statusCode == 200)
    {
      return ConsignmentNote.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteConsignmentNote(int id) async
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