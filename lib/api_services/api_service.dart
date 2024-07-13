import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:myapp/models/inventory.dart';

class ApiServices {
  static const String baseUrl =
      'https://api.timbu.cloud/products?organization_id=cd64248da13544ed86c9fc71223b780f&Appid=56H6H09J7DHO5WE&Apikey=6e023cfaa4dd48f3a2e577aa48981ee820240713161044674604';
  Future<Inventory> loadInventory() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
      );
      return Inventory.fromJson(jsonDecode(response.body));
    } on SocketException {
      throw Exception(
          'No Internet connection found. Please check your internet connection and try again');
    } on TimeoutException {
      throw Exception(
          'The request took too long to complete. Please check your internet connection and try again.');
    } catch (e) {
      print(e);
      throw Exception(
          'An unknown error occurred. Please close the app and reopen it.');
    }
  }
}
