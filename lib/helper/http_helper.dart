import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

Future<List<dynamic>> getLatLangFromQuery(String query) async {
  try {
    final uri = Uri.https(
      'api.mapbox.com',
      '/geocoding/v5/mapbox.places/$query.json',
      {'access_token': dotenv.env['MAP_BOX_ACCESS_TOKEN']},
    );
    final response = await get(uri);
    final lattLong = jsonDecode(response.body)['features'].first['center'];

    debugPrint(lattLong.toString());
    return lattLong;
  } catch (e) {
    debugPrint(e.toString());
    rethrow;
  }
}
