import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Info.dart';

class Utils {
  webboardList() async {
    Map _map = {};
    _map.addAll({
      //"uid": uid,
    });
    var body = json.encode(_map);
    final response = await http.Client().post(Uri.parse(Info().webboardList), headers: {"Content-Type": "application/json"}, body: body);
    return json.decode(response.body);
  }
}
