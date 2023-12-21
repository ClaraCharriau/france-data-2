import 'package:flutter_examen1/models/departement.model.dart';

class DepartementList {
  final List<Departement> departements;

  DepartementList({required this.departements});

  factory DepartementList.fromJson(List<dynamic> parseJson) {
    List<Departement> departements = <Departement>[];

    departements = parseJson.map((departement) => Departement.fromJson(departement)).toList();

    return DepartementList(departements: departements);
  }
}
