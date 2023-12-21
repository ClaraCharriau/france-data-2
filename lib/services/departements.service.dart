import 'dart:convert';

import 'package:flutter_examen1/models/departement_list.model.dart';

import 'package:http/http.dart' as http;

class DepartementService {
  static Future<DepartementList?> getDepartements(String regionCode) async {
    String departementsByRegionPath =
        "https://geo.api.gouv.fr/regions/$regionCode/departements";

    try {
      final response = await http.get(Uri.parse(departementsByRegionPath));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final DepartementList departements =
            DepartementList.fromJson(jsonDecode(response.body));
        return departements.departements.isNotEmpty ? departements : null;
      }
      throw Exception('Failed to load departements');
    } catch (e) {
      print(e.toString());
      throw Exception('Exception : Failed to load departements');
    }
  }

  // static Future<int?> getDepartementsTotal(String regionCode) async {
  //   String departementsByRegionPath =
  //       "https://geo.api.gouv.fr/regions/$regionCode/departements";

  //   try {
  //     final response = await http.get(Uri.parse(departementsByRegionPath));

  //     if (response.statusCode == 200 && response.body.isNotEmpty) {
  //       final DepartementList departements =
  //           DepartementList.fromJson(jsonDecode(response.body));
  //       return departements.departements.isNotEmpty
  //           ? departements.departements.length
  //           : 0;
  //     }
  //     throw Exception('Failed to load departements');
  //   } catch (e) {
  //     print(e.toString());
  //     throw Exception('Exception : Failed to load departements');
  //   }
  // }
}
