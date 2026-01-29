import 'dart:convert';
import 'package:drivado_b2b_app/models/place_suggestion/place_suggestion.dart';
import 'package:http/http.dart' as http;

Future<List<PlaceSuggestion>> fetchPlaces(String query) async {
  final response = await http.get(Uri.parse('https://api.drivado.com/api/v2/booking/autocomplete?input=$query'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    print('data ========= $data');
    if (data is List) {
      return data.map<PlaceSuggestion>((item) => PlaceSuggestion.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected response format');
    }
  } else {
    throw Exception('Failed to fetch places');
  }
}