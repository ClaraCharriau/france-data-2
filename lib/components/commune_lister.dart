import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/commune.model.dart';
import 'package:flutter_examen1/models/commune_list.model.dart';
import 'package:flutter_examen1/pages/404_page.dart';
import 'package:flutter_examen1/services/dialog.service.dart';
import 'package:flutter_examen1/services/geoGouv.service.dart';

class CommuneLister extends StatefulWidget {
  const CommuneLister(
      {super.key, required this.departement, required this.departementCode});

  final String departement;
  final String departementCode;

  @override
  State<CommuneLister> createState() => _CommuneListerState();
}

class _CommuneListerState extends State<CommuneLister> {
  late Future<CommuneList?> communes;

  late String departement;
  late String departementCode;

  void _loadDepartements() {
    setState(() {
      communes = GeoGouvService.getCommunes(widget.departementCode);
    });
  }

  @override
  void initState() {
    super.initState();
    departement = widget.departement;
    departementCode = widget.departementCode;
    _loadDepartements();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: communes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Commune> communes = snapshot.data!.communes;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Le département $departement ($departementCode) compte ${communes.length} communes."
                    "\nCliquez sur l'une des communes pour en savoir plus...",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.communes.length,
                    itemBuilder: (context, index) {
                      Commune commune = communes[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                child: ListTile(
                                    title: Text(commune.nom),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Population: ${commune.population},"
                                            "\nCde.Post.: ${commune.codesPostaux}"),
                                      ],
                                    ),
                                    onTap: () => DialogService.communeDetailsDialog(
                                          context,
                                          commune,
                                        ))),
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
