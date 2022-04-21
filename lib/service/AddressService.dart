import 'package:retail/model/Address.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddressService
{
  final String _url = 'http://localhost:8080/addresses';
  final String _url1 = 'http://localhost:8080/addresses/1';
  Map<String, String> headers = {
    "content-type": "application/json",
    "accept": "application/json",
  };

  Future<Address> getAddress() async
  {
    final response = await http.get(Uri.parse(_url1));

    if (response.statusCode == 200)
    {
      return Address.fromJson(jsonDecode(response.body));
    } else{
      throw Exception('Failed to load server data');
    }
  }

  Future<List<Address>> fetchAddresses() async
  {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseJson = json.decode(response.body);
      return (responseJson as List).map((p) => Address.fromJson(p)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load server data');
    }
  }

  Future<Address> postAddress() async
  {
    final response = await http.post(Uri.parse(_url));

    if (response.statusCode == 200)
    {
      return Address.fromJson(jsonDecode(response.body));

    } else {
      throw Exception('Failed to load server data');
    }
  }
}