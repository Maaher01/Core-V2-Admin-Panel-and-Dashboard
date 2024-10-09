import 'dart:convert';
import 'package:flutter/services.dart';

class MenuService {
  Future<List<dynamic>> fetchMenuItems() async {
    final String response = await rootBundle.loadString('lib/data/menu.json');
    final data = json.decode(response);
    return data;
  }
}
