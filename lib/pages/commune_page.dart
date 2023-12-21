import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/commune_lister.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';

class CommunePage extends StatelessWidget {
  const CommunePage
(
      {super.key, required this.config, required this.departement, required this.departementCode});

  final Config config;
  final String departement;
  final String departementCode;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Département: $departement",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(config: config, currentPage: ""),
      body: 
        CommuneLister(departementCode: departementCode, departement: departement),
    );
  }
}
