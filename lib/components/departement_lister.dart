import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/models/departement_list.model.dart';
import 'package:flutter_examen1/pages/404_page.dart';
import 'package:flutter_examen1/pages/commune_page.dart';
import 'package:flutter_examen1/services/geoGouv.service.dart';

class DepartementLister extends StatefulWidget {
  const DepartementLister(
      {super.key,
      required this.regionCode,
      required this.region,
      required this.config});

  final String regionCode;
  final String region;
  final Config config;

  @override
  State<DepartementLister> createState() => _DepartementListerState();
}

class _DepartementListerState extends State<DepartementLister> {
  late Future<DepartementList?> departements;

  late String region;
  late String regionCode;

  void _loadDepartements() {
    setState(() {
      departements = GeoGouvService.getDepartements(widget.regionCode);
    });
  }

  void _redirectToCommunePage(String departement, String departementCode) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommunePage(
                config: widget.config,
                departement: departement,
                departementCode: departementCode)));
  }

  @override
  void initState() {
    super.initState();
    region = widget.region;
    regionCode = widget.regionCode;
    _loadDepartements();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: departements,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Departement> departements = snapshot.data!.departements;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "La région $region ($regionCode) compte ${departements.length} départements.\nCliquez sur l'un des département pour en savoir plus...",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.departements.length,
                    itemBuilder: (context, index) {
                      Departement departement = departements[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: InkWell(
                                // InkWell, zone cliquable comme un bouton
                                onTapDown: (TapDownDetails details) {
                                  _redirectToCommunePage(
                                      departement.nom, departement.code);
                                },
                                child: ListTile(
                                  title: Text(departement.nom),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Code du département: ${departement.code}"),
                                    ],
                                  ),
                                  onTap: () {
                                    _redirectToCommunePage(
                                        departement.nom, departement.code);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Page404();
          }
          // Loading spinner
          return const CircularProgressIndicator();
        });
  }
}
