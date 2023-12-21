import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/commune.model.dart';
import 'package:flutter_examen1/models/commune_list.model.dart';
import 'package:flutter_examen1/services/communes.service.dart';

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

  void loadDepartements() {
    setState(() {
      communes = CommuneService.getCommunes(widget.departementCode);
    });
  }

  @override
  void initState() {
    super.initState();
    departement = widget.departement;
    departementCode = widget.departementCode;
    loadDepartements();
  }

  Future<void> _dialogBuilder(BuildContext context, Commune commune) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
                                    title: const Text('Détails de la commune'),
                                    content: Text(
                                      'Nom: ${commune.nom}\n'
                                      'Code: ${commune.code}\n'
                                      'CodeDep: ${commune.codeDepartement}\n'
                                      'Siren: ${commune.siren}\n'
                                      'Code Epci: ${commune.codeEpci}\n'
                                      'Population: ${commune.population}\n'
                                      'Code Postaux: ${commune.codesPostaux}\n',
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: const Text('Fermer'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
      }
    );
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
                    "Le département $departement ($departementCode) compte ${communes.length} communes.\nCliquez sur l'une des communes pour en savoir plus...",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Population: ${commune.population},\nCde.Post.: ${commune.codesPostaux}"),
                                  ],
                                ),
                                onTap: () => _dialogBuilder(context, commune)
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
            return Text('${snapshot.error}');
          }
          // Loading spinner
          return const CircularProgressIndicator();
        });
  }
}
