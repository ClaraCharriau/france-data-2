class Commune {
    String nom;
    String code;
    String codeDepartement;
    String siren;
    String codeEpci;
    String codeRegion;
    List<String> codesPostaux;
    int population;

    Commune({
        required this.nom,
        required this.code,
        required this.codeDepartement,
        required this.siren,
        required this.codeEpci,
        required this.codeRegion,
        required this.codesPostaux,
        required this.population,
    });

    factory Commune.fromJson(Map<String, dynamic> json) => Commune(
        nom: json["nom"],
        code: json["code"],
        codeDepartement: json["codeDepartement"],
        siren: json["siren"],
        codeEpci: json["codeEpci"],
        codeRegion: json["codeRegion"],
        codesPostaux: List<String>.from(json["codesPostaux"].map((x) => x)),
        population: json["population"],
    );

    Map<String, dynamic> toJson() => {
        "nom": nom,
        "code": code,
        "codeDepartement": codeDepartement,
        "siren": siren,
        "codeEpci": codeEpci,
        "codeRegion": codeRegion,
        "codesPostaux": List<dynamic>.from(codesPostaux.map((x) => x)),
        "population": population,
    };
}
