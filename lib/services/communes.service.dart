import 'dart:convert';

import 'package:flutter_examen1/models/commune_list.model.dart';

import 'package:http/http.dart' as http;

class CommuneService {
  static Future<CommuneList?> getCommunes(String departementCode) async {
    String communesByDepPath =
        "https://geo.api.gouv.fr/departements/$departementCode/communes";

        print("GET $communesByDepPath");

    try {
      final response = await http.get(Uri.parse(communesByDepPath));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final CommuneList communes =
            CommuneList.fromJson(jsonDecode(response.body));
        return communes.communes.isNotEmpty ? communes : null;
      }
      throw Exception('Failed to load communes');
    } catch (e) {
      print(e.toString());
      throw Exception('Exception : Failed to load communes');
    }
  }
}