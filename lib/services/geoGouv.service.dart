import 'dart:convert';

import 'package:flutter_examen1/models/commune_list.model.dart';
import 'package:flutter_examen1/models/departement_list.model.dart';

import 'package:http/http.dart' as http;

String geoGouvPath = "https://geo.api.gouv.fr/regions";

class GeoGouvService {
  static Future<DepartementList?> getDepartements(String regionCode) async {
    String departementsByRegionPath = "$geoGouvPath/regions/$regionCode/departements";

    try {
      final response = await http.get(Uri.parse(departementsByRegionPath));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final DepartementList departements =
            DepartementList.fromJson(jsonDecode(response.body));
        return departements.departements.isNotEmpty ? departements : null;
      }
      throw Exception(
          'Failed to load departements : Code ${response.statusCode}');
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load departements');
    }
  }

  static Future<CommuneList?> getCommunes(String departementCode) async {
    String communesByDepPath = "$geoGouvPath/departements/$departementCode/communes";

    try {
      final response = await http.get(Uri.parse(communesByDepPath));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final CommuneList communes =
            CommuneList.fromJson(jsonDecode(response.body));
        return communes.communes.isNotEmpty ? communes : null;
      }
      throw Exception('Failed to load communes : Code ${response.statusCode}');
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load communes');
    }
  }
}
