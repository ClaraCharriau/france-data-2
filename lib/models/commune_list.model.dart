import 'package:flutter_examen1/models/commune.model.dart';

class CommuneList {
  final List<Commune> communes;

  CommuneList({required this.communes});

  factory CommuneList.fromJson(List<dynamic> parseJson) {
    List<Commune> communes = <Commune>[];

    communes = parseJson.map((communes) => Commune.fromJson(communes)).toList();

    return CommuneList(communes: communes);
  }
}
