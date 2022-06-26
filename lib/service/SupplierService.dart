import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../model/Supplier.dart';

class SupplierService
{
  final String _url = 'http://localhost:8080/supplier';

  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<Supplier> getSupplier(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return Supplier.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Supplier>> getSupplierList() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Supplier.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Supplier> addSupplier(Supplier supplier) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(supplier.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return Supplier.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Supplier> putSupplier(Supplier supplier, int id) async
  {

    final response = await http.put(Uri.parse(_url + "/$id"), headers: headers, body: json.encode(supplier.toJson()));

    if (response.statusCode == 200)
    {
      return Supplier.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<String> deleteSupplier(int id) async
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