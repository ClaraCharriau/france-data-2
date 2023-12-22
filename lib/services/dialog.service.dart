import 'package:flutter/material.dart';
import 'package:flutter_examen1/models/commune.model.dart';

class DialogService {

  static Future<void> communeDetailsDialog(BuildContext context, Commune commune) {
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
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Fermer'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}