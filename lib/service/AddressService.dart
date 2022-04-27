import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddressService
{
  final String _url = 'http://localhost:8080/addresses';
  final String _url1 = 'http://localhost:8080/addresses/1';
  Map<String, String> headers = {
    "content-type": "application/json; charset=UTF-8",
    "accept": "application/json",
  };

  Future<Address> getAddress(int id) async
  {
    final response = await http.get(Uri.parse(_url + "/$id"));
    //статус 200 - хорошо
    if (response.statusCode == 200)
    {
      return Address.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Address>> getAddresses() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Address.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Address> addAddress(Address address) async
  {
    final response = await http.post(Uri.parse(_url), headers: headers, body: json.encode(address.toJson()));
    //статус 201 - создан
    if (response.statusCode == 201)
    {
      return Address.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }

  Future<Address> putAddress(Address address) async
  {
    final response = await http.put(Uri.parse(_url1), headers: headers, body: json.encode(address.toJson()));

    if (response.statusCode == 200)
    {
      return Address.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load server data');
    }
  }
}