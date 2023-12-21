import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/departement_lister.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';

class DepartementPage extends StatelessWidget {
  const DepartementPage(
      {super.key, required this.config, required this.region});

  final Config config;
  final String region;

  @override
  Widget build(BuildContext context) {
    final String regionCode = config.get('regions.$region.code');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Région: $region",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(config: config, currentPage: ""),
      body: 
        DepartementLister(regionCode: regionCode, region: region),
    );
  }
}
